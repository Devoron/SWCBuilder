package devoron.aslc.moduls.output
{
	import devoron.sdk.data.CompilerMessage;
	import devoron.studio.moduls.code.tools.resultslist.CompilerMessagesListCellRenderer;
	import org.aswing.ASColor;
	import org.aswing.GeneralListCellFactory;
	import org.aswing.JList;
	import org.aswing.ListCellFactory;
	
	public class CompilerMessagesList extends JList
	{
		private var _messages:Vector.<CompilerMessage>;
		public static var instance:CompilerMessagesList;
		
		public function CompilerMessagesList(listData:*=null, cellFactory:ListCellFactory=null)
		{
			super(listData, cellFactory);
			setForeground(new ASColor(0xFFFFFF, 0.45));
			setSelectionBackground(new ASColor(0x000000, 0.14));
			setSelectionForeground(new ASColor(0XFFFFFF, 0.65));
			setCellFactory(new GeneralListCellFactory(CompilerMessagesListCellRenderer, true, true, 20));
			instance = this;
		}
		
		public function set messages(list:Vector.<CompilerMessage>):void
		{
			if (!list)
			{
				_messages = new Vector.<CompilerMessage>;
				setListData([]);
				return;
			}
			_messages = list;
			var a:Array = [];
			for each (var msg:CompilerMessage in list)
			{
				if (msg.level == 'info') continue;
				a.push(msg);
			}
			setListData(a);
		}
		
		public function get messages():Vector.<CompilerMessage>
		{
			return _messages;
		}
		
		public function get selectedMessage():CompilerMessage
		{
			return getSelectedValue();
		}
	}
}