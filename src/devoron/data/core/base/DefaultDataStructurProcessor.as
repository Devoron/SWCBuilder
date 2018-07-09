package devoron.data.core.base 
{
	import devoron.components.tables.INewValueGenerator;
	import devoron.studio.core.base.StudioParser;
	import devoron.studio.devoron_studio;
	import flash.events.Event;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;
	import org.aswing.Component;
	import org.aswing.event.SelectionEvent;
	/**
	 * ...
	 * @author Devoron
	 */
	public class DefaultDataStructurProcessor implements IDataProcessor
	{
		private var dataComponents:Vector.<IDataModul>;
		private var dataStructurGenerator:INewValueGenerator;
		private var parserCls:Class;
		private var dataStructursTableModel;
		private var dataStructurs;
		private var dataStructursTableSelectionModel;
		private var _filePath:String;
		private var _status;
		private var _percentReady;
		private var dataStructursTable;
		private var _changed;
		
		public function DefaultDataStructurProcessor(dataStructurCls:Class) 
		{
			dataStructurGenerator = new DefaultDataStructurGenerator(dataStructurCls);
		}
		
		public function setDataStructurParserClass(parserCls:Class):void {
			this.parserCls = parserCls;
		}
		
		public function parseDataStructur(source:DataStructur, resultHandler:Function = null, errorHandler:Function = null):void{
			StudioParser.parse(source.dataCode, "mesh", resultHandler, errorHandler, null, null, parserCls);
		}
		
		
		public function getDataStructurGenerator():INewValueGenerator {
			return dataStructurGenerator;
		}
		
		
		/**
		 * Обработчик нажатия кнопки copyDataStructurBtn.
		 * @param	e
		 */
		protected function copyDataStructurBtnHandler(e:Event):void
		{
			var selectedIndices:Array = dataStructursTable.getSelectedRows();
			
			// если структура данных не выбрана, то ничего предпринимать не следует
			if (!selectedIndices.length)
				return;
			
			var structursCount:uint;
			var dataStructur:DataStructur;
			var selId:int = 0;
			
			for each (selId in selectedIndices)
			{
				//dataStructur = (dataStructursTableModel.getData()[dataStructursTable.getSelectedRow()]).clone();
				structursCount = dataStructurs.push((dataStructurs[selId]).clone());
			}
			
			dataStructursTableModel.setData(dataStructurs);
			dataStructursTable.revalidate();
			selId = structursCount - 1;
			dataStructursTableSelectionModel.setSelectionInterval(selId, selId);
		}
		
		/**
		 * Обработчик выбора в таблице мешей.
		 * @param	e
		 */
		protected function dataTableSelectionHandler(e:SelectionEvent):void
		{
			if (dataStructursTable.getSelectedRowCount() > 1)
				return;
			
			var selId:int = dataStructursTable.getSelectedRow();
			if (selId == -1)
				return;
			
			// выбранная структура данных
			var dataStructur:DataStructur = dataStructursTableModel.getData()[selId];
			setSelectedDataStructur(dataStructur);
		}
		
		
		protected function setSelectedDataStructur2(dataStructur:DataStructur):void
		{
			// имена контейнеров, связанных с этой структурой данных
			var dataContainersNames:Array = dataStructur.getDataContainersNames();
			
			trace("Новый выбор " + dataContainersNames);
			
			if (dataContainersNames.length == 0)
				return;
			
			// добавить в структуру контейнеры параметров
			// возможные контейнеры должны быть закэшированы
			var dataParametersObj:*;
			/*for each (dataParametersObj in devoron_studio::modulComponents)
			{
				if (dataParametersObj is IDataContainer)
				{
					var data:Object = dataStructur.getDataByContainerName(IDataContainer(dataParametersObj).dataContainerName);
					IDataContainer(dataParametersObj).setDataToContainer(data);
				}
				else if (dataParametersObj is IDataStructurContainer)
					dataParametersObj.setDataStructur(dataStructur);
			}*/
			
			
			dataStructur.serialize();
		}
		
		public function getDataStructurs():Array
		{
			return dataStructurs;
		}
		
		protected function getNewDataStructurName():String
		{
			//return ArrayNamesHelper.createNewOrdinalName([, "dataName", dataName)
			return "newTESTFILE";
			//return ArrayNamesHelper.createNewOrdinalName(dataStructursTableModel.getData(), "dataName", dataName)
		}
		
		public function addNewDataStructur():DataStructur
		{
			//dataProcessorsDomain.getDataProcessor(getUID()).generateData
			
			//dataProcessorsDomain.getDataProcessor(getUID()).generateData();
			
			//var dataStructur:DataStructur = new dataStructurClass();
			var dataStructur:DataStructur/* = new dataStructurClass()*/;
			dataStructur.dataName = getNewDataStructurName();
			//dataStructur.addSerializeObserver(this);
			
			var dataParametersObj:*;
			var dataModuls:Vector.<IDataModul> = new Vector.<IDataModul>;
			for each (dataParametersObj in super.modulComponents)
			{
				/*if (dataParametersObj is IDataContainer)
					dataStructur.addDataContainer(dataParametersObj);
				else if (dataParametersObj is IDataStructurContainer)
					dataParametersObj.setDataStructur(dataStructur);*/
					
					if ((dataParametersObj is IDataContainer) || (dataParametersObj is IDataStructurContainer))
					dataModuls.push(dataParametersObj);
			}
			//dataProcessorsDomain.getDataProcessor(getUID()).registerDataModuls(dataModuls);
			//dataProcessorsDomain.getDataProcessor(getUID()).processData(dataStructur, null);
			
			dataStructur.serializable = true;
			return dataStructur;
		}
		
		/**
		 * Обработчик нажатия кнопки removeDataStructurBtn.
		 * @param	e
		 */
		public function removeDataStructurBtnHandler(e:Event):void
		{
			
			var selectedIndices:Array = dataStructursTable.getSelectedRows();
			
			// если структура данных не выбрана, то ничего предпринимать не следует
			if (!selectedIndices.length)
				return;
			
			var selId:int = 0;
			selectedIndices.reverse();
			
			//removeAllLinks(selectedIndices);
			
			for each (selId in selectedIndices)
			{
				//bitmapFontId = dataStructurs[selId].getDataByContainerName("BitmapFontId").bitmapFontId;
				
				// уничтожить каждую структуру данных
				for each (selId in selectedIndices)
				{
					dataStructurs[selId].dispose();
					dataStructurs[selId] = null;
					
					// удалить из модели таблицы
					dataStructursTableModel.removeRow(selId);
				}
				
				// установить выбранной предыдущую структуру (или следующую, если  нет)
				var structursCount:uint = dataStructurs.length;
				if (structursCount > 0)
				{
					selId = selId < structursCount ? selId : structursCount - 1;
					dataStructursTableSelectionModel.setSelectionInterval(selId, selId);
				}
			}
		}
		
		protected function setSelectedDataStructur(dataStructur:DataStructur):void
		{
			// имена контейнеров, связанных с этой структурой данных
			var dataContainersNames:Array = dataStructur.getDataContainersNames();
			
			trace("Новый выбор " + dataContainersNames);
			
			if (dataContainersNames.length == 0)
				return;
			
			// добавить в структуру контейнеры параметров
			// возможные контейнеры должны быть закэшированы
			var dataParametersObj:*;
			/*for each (dataParametersObj in devoron_studio::modulComponents)
			{
				if (dataParametersObj is IDataContainer)
				{
					var data:Object = dataStructur.getDataByContainerName(IDataContainer(dataParametersObj).dataContainerName);
					IDataContainer(dataParametersObj).setDataToContainer(data);
				}
				else if (dataParametersObj is IDataStructurContainer)
					dataParametersObj.setDataStructur(dataStructur);
			}*/
			
			
			dataStructur.serialize();
		}
		
		
		/* INTERFACE devoron.data.core.base.IDataProcessor */
		
		public function removeLinks(uids:Array, processorsDomain:IDataProcessorDomain = null, targets:Vector.<IDataProcessor> = null):void 
		{
			
		}
		
		public function generateData():* 
		{
			
		}
		
		public function registerDataModuls(dataModuls:Vector.<IDataModul>):void 
		{
			
		}
		
		public function processData(data:*, targetModuls:Vector.<IDataModul> = null):void 
		{
			
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeekReference:Boolean = false):void 
		{
			PrintJob
		}
		
		public function getView():Component 
		{
			return null;
		}
		
		public function setView(view:Component, options:Object):void 
		{
			
		}
		
		public function set filePath(value:String):void 
		{
			_filePath = value;
		}
		
		public function get filePath():String 
		{
			return _filePath;
		}
		
		public function get status():String 
		{
			return _status;
		}
		
		public function get percentReady():Number 
		{
			return _percentReady;
		}
		
		public function get changed():Boolean 
		{
			return _changed;
		}
		
		public function getUID():String 
		{
			return "SDJFKLJ";
		}
		
	}

}