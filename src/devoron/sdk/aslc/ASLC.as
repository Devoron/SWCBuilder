package devoron.sdk.aslc 
{
	import devoron.sdk.compiler.as3code.ClassProxy;
	import org.aswing.util.HashMap;
	/**
	 * ...
	 * @author Devoron
	 */
	public class ASLC 
	{
		// этот объект встраивается в конструктор класса имеющего live-unit'ы b хранит в себе прямые ссылки для конкретного экземпляра класса на установленные liveUnits
		// ASCL обновляет этот каждый раз при изменении своих данных
		private var liveClassUnits:Object;
		
		public function ASLC() 
		{
			//ASLC.registerClass(this, __this, __super);
			// aslc(obj).run(hui, "хуй с горы");
		}
		
		public function ourLiveFunction():* {
			return liveClassUnits["ourLiveFunction"].call(arguments);
		}
		
		/**
		 * В списке элементов класса при установке элемента как live формируется новый LiveUID для 
		 * этого объекта.
		 * Быстрый доступ к объектам осуществляется через UID'ы
		 * @param	id
		 * @return
		 */
		public function call(id:String, args:Array):* {
			return null;
		}
		
		static public function getClassProxy(target:*, ___thisFunction:Function):ClassProxy
		{
			//trace("dfsjkfjds");
			//return null;
			return new ClassProxy(___thisFunction, ___thisFunction);
		}
		
		//public function classUnit(id:String, 
		
	}

}