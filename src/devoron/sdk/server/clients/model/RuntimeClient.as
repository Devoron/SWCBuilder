package devoron.sdk.server.clients.model 
{
	import be.aboutme.airserver.Client;
	import be.aboutme.airserver.endpoints.IClientHandler;
	/**
	 * RuntimeClient
	 * @author Devoron
	 */
	public class RuntimeClient extends Client
	{
		public function RuntimeClient(id:uint, clientHandler:IClientHandler) 
		{
			super(id, clientHandler);
		}
		
	}

}