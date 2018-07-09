package devoron.sdk.server.clients.model 
{
	import devoron.sdk.server.clients.model.RuntimeClient;
	import org.aswing.VectorListModel;
	import be.aboutme.airserver.Client;

	/**
	 * RuntimeClientsModel
	 * @author Devoron
	 */
	public class RuntimeClientsModel extends VectorListModel
	{
		
		public function RuntimeClientsModel() 
		{
			
		}
		
		override public function append(obj:*, index:int = -1):void 
		{
			//if (!(client is RuntimeClient)) {
				//throw new Error("Client must extend RuntimeClient class");
			//}
			//super.append(obj, index);
			super.append(obj, index);
			
			//var client:RuntimeClient = obj as RuntimeClient;
			//trace("добавлен новый клиент " + client.id);
		}
		
	}

}