package devoron.sdk.aslc.core.utils 
{
	import devoron.sdk.aslc.core.code.ICodeController;
	/**
	 * RemovedMembersFinder
	 * @author Devoron
	 */
	public class RemovedMembersFinder 
	{
		private var codeController:ICodeController;
		
		public function RemovedMembersFinder(codeController:ICodeController) 
		{
			this.codeController = codeController;
			
		}
		
		public function findRemovedMembers():void 
		{
			// сообщить контроллеру, что нужно удалить метод
			codeController.removeMember(null);
		}
		
	}

}