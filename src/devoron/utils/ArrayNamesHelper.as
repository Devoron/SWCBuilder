package devoron.utils 
{
	/**
	 * ArrayNamesHelper
	 * @author Devoron
	 */
	public class ArrayNamesHelper 
	{
		
		public function ArrayNamesHelper() 
		{
			
		}
		
		/**
		 * Проверить уникальное имя в массивах из объектов.
		 * @param	datas массив данных
		 * @param	field поле, значение которого следует проверять у каждого объекта
		 * @param	name имя поля
		 * @return
		 */
		public static function checkUnicalName(datas:Array, field:*, name:String):Boolean {
			for each (var item:* in datas) 
			{
				if (item[field] == name) return false; 
			}
			return true;
		}
		
		/**
		 * Проверить уникальное имя в массивах из объектов.
		 * @param	datas массив данных
		 * @param	field поле, значение которого следует проверять у каждого объекта
		 * @param	name имя поля
		 * @return
		 */
		public static function checkUnicalNameWithException(datas:Array, field:*, name:String, id:int):Boolean {
			var len:uint = datas.length;
			for (var i:int = 0; i < len; i++) 
			{
				if (i == id) continue;
				if (datas[i][field] == name) return false; 
			}
			return true;
		}
		
		/**
		 * Создание нового упорядоченного имени в массиве.
		 * Например, material1, geometry23 и т.д.
		 * @param	datas массив объектов
		 * @param	field поле, содержащее имя(String). Например, "name". Если оно глубоко вложено, то Array ["people", "name"]
		 * @param	typedWord типизированное имя-слово. Например, "material" или "geometry"
		 * @param	firstIndex начальный индекс создаваемого имени
		 * @return
		 */
		public static function createNewOrdinalName(datas:Array, field:*, typedWord:String, firstIndex:uint = 1):String {
			var tempArr:Array = [];
			var value:*;
			var numberPart:*;
			// собрать все элементы, которые в поле field содержат typedWord+число
			for each (var item:* in datas) 
			{
				value = (field==null) ? item : item[field];
				// если данное поле является строкой
				if (value is String) {
					// если имя начинается с типизированного слова
					if ( value.indexOf(typedWord) == 0) {
						// если оставшаяся часть поля является цифровой
						numberPart = value.substring(typedWord.length, value.length);
						if ( !isNaN(Number(numberPart))) {
							tempArr.push(numberPart);
						}
					}
				}
			}
			
			// упорядочить массив в цифровом порядке
			tempArr.sort(Array.NUMERIC);
			var count:uint = tempArr.length;
			
			// если значений нет, то создать первый результат
			if(count == 0) return typedWord+String(firstIndex);
			
			// если самое первое значение больше firstIndex, то результат - firstIndex+1
			//value = tempArr[0];
			//value = Number(value.substring(typedWord.length, value.length));
			if (tempArr[0] > firstIndex) return typedWord+String(firstIndex);
			
			// если между двумя соседними есть свободные индексы, то результат найден
			// иначе результат - последний индекс + 1
			
			var nextValue:*;
			for (var i:int = 0; i < count; i++) 
			{
				value = tempArr[i];
				if ( (i + 1) <= (count -1)) {
					nextValue = tempArr[i + 1];
					// если между вторым и первым значением разница больше, чем 1, то есть результат
					if (nextValue - value > 1) {
						return typedWord + String(Number(value)+1);
					}
				}
				else if (i == count - 1) {
					//gtrace("вот этот случай");
					return typedWord + String(count+1);
				}
			}
			
			return typedWord+String(firstIndex);
		}
		
	}

}