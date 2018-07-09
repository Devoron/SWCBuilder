package devoron.data
{
	import devoron.data.core.base.SimpleDataComponent;
	import avmplus.R;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import org.aswing.JNumberStepper;
	import org.aswing.util.HashMap;
	
	/**
	 * GetSetFunctionsHash
	 * @author Devoron
	 */
	public class GetSetFunctionsHash
	{
		private static var hash:HashMap;
		private static var inited:Boolean = false;
		
		public function GetSetFunctionsHash()
		{
		}
		
		private static function init():void
		{
			new SimpleDataComponent("");
			
			hash = new HashMap();
			hash.put("devoron.studio.tools.textureeditor.ui.util.GradientValueComponent", ["getRelatedGradientValue", "setRelatedGradientValue"]);
			hash.put("devoron.studio.tools.guibuilder.forms.IntDimensionForm", ["getRelatedIntDimension", "setRelatedIntDimension"]);
			hash.put("org.aswing.ButtonGroup", ["getSelectedIndex", "setSelectedIndex"]);
			hash.put("org.aswing.JNumberStepper", ["getValue", "setValue"]);
			hash.put("devoron.studio.texteditor.TextValueComponent", ["getRelatedTextValue", "setRelatedTextValue"]);
			hash.put("devoron.values.models.TreeModelValueComponent", ["setModel", "getModel"]);
			hash.put("devoron.components.values.color.ColorChooserForm", ["getColor", "setColor"]);
			hash.put("devoron.data.core.SimpleDataComponent", ["getData", "setData"]);
			hash.put("org.aswing.JTable", ["getData", "setData"]);
			hash.put("org.aswing.JSlider", ["getValue", "setValue"]);
			hash.put("devoron.components.SliderForm", ["getValue", "setValue"]);
			hash.put("org.aswing.JToggleButton", ["isSelected", "setSelected"]);
			hash.put("org.aswing.JStepper", ["getValue", "setValue"]);
			hash.put("org.aswing.JCheckBox", ["isSelected", "setSelected"]);
			hash.put("org.aswing.JTextComponent", ["getText", "setText"]);
			hash.put("org.aswing.JTextField", ["getText", "setText"]);
			hash.put("org.aswing.JComboBox", ["getSelectedItem", "setSelectedItem"]);
			hash.put("devoron.components.color.ColorChooserForm", ["getColor", "setColor"]);
			hash.put("org.aswing.JKnob", ["getValue", "setValue"]);
			hash.put("devoron.components.TypedListForm", ["getData", "setData"]);
			hash.put("devoron.components.devoron.components.multicontainers.table.DataContainersTable", ["getData", "setData"]);
			hash.put("devoron.components.values.oneD.OneDValueComponent", ["getRelatedOneDValue", "setRelatedOneDValue"]);
			hash.put("devoron.components.values.threeD.ThreeDValueComponent", ["getRelatedThreeDValue", "setRelatedThreeDValue"]);
			hash.put("devoron.components.values.fourD.FourDCompositeWithThreeDComponent", ["getRelatedFourDValue", "setRelatedFourDValue"]);
			hash.put("devoron.components.values.fourD.FourDCompositeWithOneDComponent", ["getRelatedFourDValue", "setRelatedFourDValue"]);
			hash.put("devoron.components.values.color.CompositeColorComponent", ["getRelatedCompositeColor", "setRelatedCompositeColor"]);
			hash.put("devoron.components.values.color.ConstColorComponent", ["getRelatedConstColor", "setRelatedConstColor"]);
			hash.put("devoron.components.PathChooserForm", ["getPath", "setPath"]);
			hash.put("devoron.components.values.cubetexture.CubeTextureComponent", ["getRelatedCubeTexturePath", "setRelatedCubeTexturePath"]);
			hash.put("devoron.components.texturecomponent.ITextureDataForm", ["getRelatedTextureData", "setRelatedTextureData"]);
			hash.put("devoron.components.pcfs.PathChooserForm", ["getPath", "setPath"]);
			hash.put("devoron.components.pcfs.ImagePCF", ["getPath", "setPath"]);
			hash.put("devoron.components.checkboxes.WhiteChB", ["isSelected", "setSelected"]);
			convetToClasses();
			inited = true;
		}
		
		private static function convetToClasses():void
		{
			var keys:Array = hash.keys();
			var definitionName:String;
			var funcs:Array;
			var cls:Class;
			for (var i:int = 0; i < keys.length; i++)
			{
				definitionName = keys[i];
				funcs = hash.remove(definitionName);
				try
				{
					cls = getDefinitionByName(definitionName) as Class;
					hash.put(cls, funcs);
				}
				catch (e:Error)
				{
					//gtrace(e);
				}
			}
		}
		
		public static function registerGetValueFunction(componentClass:Class, functionName:String):void
		{
			var functions:Array = hash.get(componentClass);
			if (!functions)
				functions = [];
			functions[0] = functionName;
		}
		
		public static function registerSetValueFunction(componentClass:Class, functionName:String):void
		{
			var functions:Array = hash.get(componentClass);
			if (!functions)
				functions = [];
			functions[1] = functionName;
		}
		
		static public function unregisterGetValueFunction(componentClass:Class):void 
		{
			var functions:Array = hash.get(componentClass);
			if (!functions)
				functions = [];
			functions[0] = null;
		}
		
		static public function unregisterSetValueFunction(componentClass:Class):void 
		{
			var functions:Array = hash.get(componentClass);
			if (!functions)
				functions = [];
			functions[1] = null;
		}
		
		public static function getSupportedComponents():Array
		{
			if (!inited)
				init();
			return hash.keys();
		}
		
		/**
		 * Если компонент is Class в хэше классов, то вернуть функцию получения
		 * значения в компонент.
		 * @param	comp
		 * @return
		 */
		public static function getGetValueFunction(comp:*):Function
		{
			if (!inited)
				init();
			
			//gtrace(getQualifiedClassName(comp));
			
			if (getQualifiedClassName(comp) == "devoron.data.core::SimpleDataComponent")
				return comp.getData;
			
			if (comp is JNumberStepper)
				return comp.getValue;
			
			// ключи должны быть сохранены отдельно, чтобы не вытаскивать их каждый раз
			var keys:Array = hash.keys();
			var i:uint = keys.length - 1;
			while (i > 0)
			{
				var cls:Class = keys[i--];
				/*	if (comp is JNumberStepper) {
				   gtrace(getDefinitionByName(getQualifiedClassName(comp)) == cls);
				   gtrace(comp is cls);
				   gtrace(cls);
				   }*/
				
				//gtrace("ds");
				
				if (getQualifiedClassName(comp) == "devoron.components.color.ColorChooserForm")
					trace("djskfsjd");
				
				if (comp is cls)
				{
					/*if (comp is JNumberStepper) {
					   gtrace("dsfs");
					   }*/
					
					return comp[hash.get(cls)[0]];
					
				}
			}
			
			// если в первом цикле не удалось получить компонент с -get и -set функциями
			// то сравниваем с родителями
			var flags:int = R.BASES | R.FLASH10_FLAGS;
			var describeClass:Object = R.describe(comp, flags);
			
			var bases:Array = [];
			var base:String;
			
			describeClass.traits.bases.sortOn("name");
			
			// проход по всем родителям
			for (i = 0; i < describeClass.traits.bases.length; i++)
			{
				
				try
				{
					//cls = getDefinitionByName(definitionName) as Class;
					//hash.put(cls, funcs);
					
					// проход по всем классам в хеше
					keys = hash.keys();
					var k:int = keys.length - 1;
					while (k > 0)
					{
						if (getQualifiedClassName(keys[k]) == describeClass.traits.bases[i])
						{
							try
							{
								cls = getDefinitionByName(keys[k]) as Class;
								//hash.put(cls, funcs);
								return comp[hash.get(cls)[0]];
							}
							catch (e:Error)
							{
								//gtrace("3: " + e.message);
							}
						}
						k--;
						/*var cls:Class = keys[i--];
						   if (comp is cls)
						   {
						   return comp[hash.get(cls)[0]];
						   }*/
					}
					
				}
				catch (e:Error)
				{
					//gtrace("2: " + e.message);
				}
				
					///*base =*/ describeClass.traits.bases[i];
				/*if (base.parameters.length == 1)
				   //gtrace((method.parameters[0] as RArgumentProxy).type);
				   if ((base.parameters[0] as RArgumentProxy).type == "flash.events::MouseEvent")
				   bases.push(base.name);*/
				
					   //if ((method.parameters[0] as RArgumentProxy).type == "MouseEvent")
					   //methods.push(method.name);
					   //gtrace("method.parameters " + method.parameters);
					   //methods.push(method.name);
			}
			
			return null
		}
		
		/**
		 * Если компонент is Class в хэше классов, то вернуть функцию получения
		 * значения в компонент.
		 * @param	comp
		 * @return
		 */
		public static function getSetValueFunction(comp:*):Function
		{
			if (!inited)
				init();
			
			// заглушка!!!!!!!
			if (comp is JNumberStepper)
				return comp.setValue;
			
			// ключи должны быть сохранены отдельно, чтобы не вытаскивать их каждый раз
			var keys:Array = hash.keys();
			var i:int = keys.length - 1;
			while (i > 0)
			{
				var cls:Class = keys[i--];
				//if (comp is JNumberStepper || comp is ColorChooserForm)
				//gtrace("dsfjksd");
				
				if (comp is cls)
				{
					return comp[hash.get(cls)[1]];
				}
				i--;
			}
			
			return null
		}
		
	
	}
}