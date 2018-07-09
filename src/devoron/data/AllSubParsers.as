package devoron.data
{
	import devoron.world.light.parsers.DirectionalLightSubParser;
	import devoron.world.light.parsers.PointLightSubParser;
	import flash.utils.getQualifiedClassName;
	import org.aswing.util.HashMap;
	
	public class AllSubParsers
	{
		/*public static const ALL_FONT_MODELS:Array = [
		 {Text3D:Text3DSubParser } ];*/
		
		//public static const ALL
		
		public static const ALL_GLOBAL_VALUES:Array = [];
		
		private static var parsers:HashMap;
		public static const ALL_LIGHTS:Array = [{PointLight: PointLightSubParser}, {DirectionalLight: DirectionalLightSubParser}];
		
		public static function getParser(dataName:String):CompositeParserBase
		{
			if (parsers)
			{
				return parsers.get(dataName);
			}
			
			/**
			 * ВРЕМЕННОЕ РЕШЕНИЕ
			 * (ИБО НЕКРАСИВОЕ)
			 * (НО РАБОЧЕЕ:)
			 */
			var allParserClasses:Array = [];
			
			//allParserClasses.concat(ALL_DEBUGS);
			
			allParserClasses.concat(ALL_TRANSFORMS);
			allParserClasses.concat(ALL_GEOMETRIES);
			allParserClasses.concat(ALL_MATERIALS);
			allParserClasses.concat(ALL_CONTROLLERS);
			
			parsers = new HashMap();
			
			for each (var parserArr:Array in allParserClasses)
			{
				for each (var cls:Object in parserArr)
				{
					for (var prop:String in cls)
					{ // nextName/nextNameIndex
						parsers.put(prop, cls);
					}
				}
			}
			return parsers.get(dataName);
		}
		
		public static function getParserClassName(dataName:String):String
		{
			var parser:CompositeParserBase = getParser(dataName);
			if (parser)
				return getQualifiedClassName(parser);
			return null;
		}
		
		/**
		 * Возвращает класс парсера по идентификатору и массиву классов,
		 * в котором нужно искать.
		 * @param	identifier
		 * @param	classes
		 * @return
		 */
		public static function getRelatedParser(identifier:*, classes:Array):Class
		{
			for each (var cls:Object in classes)
				if (cls[identifier])
					return cls[identifier] as Class;
			return null;
		}
	
	}

}
