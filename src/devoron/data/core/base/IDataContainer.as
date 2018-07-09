package devoron.data.core.base 
{
	import org.aswing.Icon;
	/**
	 * Интерфейс контейнера данных.
	 * Контейнер данных обеспечивает работу с данными:
		 * устанавливает данные в себя (например, в значения ширины и высоты 
		 * из Rectangle в текстовые поля) и собирает данные из себя
		 * в объект данных (обратное действие).
	 * @author Devoron
	 */
	public interface IDataContainer extends IDataModul
	{
		function get dataContainerName():String;
		function set dataContainerName(name:String):void;
		function get dataContainerType():String;
		function set dataContainerType(name:String):void;
		function get dataContainerIcon():Icon;
		function set dataContainerIcon(icon:Icon):void;
		function setDataToContainer(data:Object):void;
		function collectDataFromContainer(data:Object = null):Object;
	}
	
}