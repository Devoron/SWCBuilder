package devoron.dataui
{
	import devoron.components.ICompositeComponent;
	import devoron.data.core.base.DataStructur;
	import devoron.data.core.base.IDataContainer;
	import devoron.data.core.base.IDataContainersManager;
	import devoron.data.core.base.IDataStructurContainer;
	import org.aswing.ext.Form;
	import org.aswing.ext.FormRow;
	import org.aswing.Icon;
	import org.aswing.util.HashMap;
	
	/**
	 * DataStructurForm
	 * @author Devoron
	 */
	public class DataStructurForm extends Form implements IDataStructurContainer, ICompositeComponent
	{
		private var dataStructur:DataStructur;
		public static const SINGLE_MODE:String = "single";
		public static const MULTI_MODE:String = "multi";
		
		protected var mode:String = "single";
		protected var dataContainerFormRows:HashMap = new HashMap();
		protected var dataContainers:HashMap = new HashMap();
		protected var supportedDataContainerClasses:Vector.<Class> = new Vector.<Class>();
		//protected var dataStructur:DataStructur;
		protected var currentContainerName:String;
		protected var containerNames:Array = [];
		protected var dataStructurIcon:Icon;
		protected var changeVisibilityOnDataContainerChange:Boolean = true;
		
		public function DataStructurForm(mode:String = DataStructurForm.SINGLE_MODE)
		{
			super();
			this.mode = mode;
		}
		
		public function get dataContainerType():String{
			return "modifiers";
		}
		
		/* INTERFACE devoron.dataloader.IDataStructurContainer */
		
		public function setDataStructur(dataStructur:IDataContainersManager):void
		{
			this.dataStructur = dataStructur as DataStructur;
			var data:Object = null;
			var containerName:String = "";
			
			// проверить, есть ли в структуре данных данные для одного из поддерживаемых контейнеров данных
			// т.е. были ли они собраны прежде
			for each (containerName in containerNames)
			{
				data = dataStructur.getDataByContainerName(containerName);
				if (data)
					break;
			}
			
			// если данные найдены, то установить их в соответствующий контейнер и сделать его текущим
			// иначе - собрать данные из текущего контейнера
			if (data)
			{
				IDataContainer(dataContainers.get(containerName)).setDataToContainer(data);
				dataContainerChange(containerName, changeVisibilityOnDataContainerChange);
			}
			else
			{
				dataStructur.addDataContainer(IDataContainer(dataContainers.get(currentContainerName)));
			}
		}
		
		public function getDataStructur():IDataContainersManager
		{
			return dataStructur;
		}
		
		/* INTERFACE devoron.gameeditor.core.ICompositeGameEditorComponent */
		
		public function getComponents():* 
		{
			return dataContainers;
		}
		
		public function getComponentByName(componentName:String):* 
		{
			return dataContainers.get(componentName);
		}
		
		/**
		 * Создать формы контейнеров данных и разместить их строками в родительской форме.
		 * @param	ownerForm родительская форма
		 * @param	gap отступ от левого края
		 */
		protected function createDataContainerForms(ownerForm:Form, gap:uint = 0, visible:Boolean = false):void
		{
			var dataContainer:*;
			var fr:FormRow;
			var dataContainerClass:Class;
			for each (dataContainerClass in supportedDataContainerClasses)
			{
				dataContainer = new dataContainerClass();
				fr = ownerForm.addLeftHoldRow(gap, dataContainer);
				fr.setVisible(visible);
				dataContainerFormRows.put((dataContainer as IDataContainer).dataContainerName, fr);
				dataContainers.put((dataContainer as IDataContainer).dataContainerName, dataContainer);
				containerNames.push((dataContainer as IDataContainer).dataContainerName);
			}
		}
		
		/**
		 * Обработчик выбора в списке моделей.
		 * @param	e
		 */
		protected function dataContainerChange(selectedContainerName:String, changeVisibility:Boolean = true):void
		{
			// если индекс не менялся, то ничего предпринимать не следует
			if (currentContainerName == selectedContainerName)
				return;
			
			var containerName:String = "";
			
			// скрыть все прочие контейнеры данных
			if (changeVisibility)
				for each (containerName in containerNames)
					dataContainerFormRows.get(containerName).setVisible(false);
			
			// удалить данные старого контейнера из структуры данных
			if (dataStructur)
				dataStructur.removeDataByContainerName(currentContainerName);
			
			// отобразить выбранный контейнер данных
			currentContainerName = selectedContainerName;
			if (changeVisibility)
				dataContainerFormRows.get(selectedContainerName).setVisible(true);
			
			// добавить контейнер в структуру данных
			if (dataStructur)
				dataStructur.addDataContainer(dataContainers.get(selectedContainerName));
		}
		
		public function get icon():Icon
		{
			return dataStructurIcon;
		}
	
	}

}