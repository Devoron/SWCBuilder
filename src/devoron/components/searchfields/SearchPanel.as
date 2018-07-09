package devoron.components.searchfields
{
	import devoron.components.buttons.DSTextField;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import net.kawa.tween.easing.Linear;
	import net.kawa.tween.KTween;
	import org.aswing.AssetIcon;
	import org.aswing.Container;
	import org.aswing.event.AWEvent;
	import org.aswing.Icon;
	import org.aswing.JDropDownButton;
	import org.aswing.JPanel;
	import org.aswing.JTextField;
	import org.aswing.layout.FlowLayout;
	//import devoron.components.icons.WatchingIcon;
	
	
	[Event(name="act",type="org.aswing.event.AWEvent")]
	[Event(name="change",type="flash.events.Event")]
	
	/**
	 * SearchPanel
	 * @author Devoron
	 */
	public class SearchPanel extends JPanel
	{
		//[Embed(source="../../../../assets/icons/commons/search_icon16.png")]
		[Embed(source="../../../../assets/icons/commons/lupa_icon20.png")]
		private const SEARCH_ICON16:Class;
		
		[Embed(source="../../../../assets/icons/commons/clear_icon8.png")]
		private const CLOSE_ICON:Class;
		
		//private var clearSearchFieldBtn:StateToggleButton;
		private var clearSearchFieldBtn:JDropDownButton;
		private var searchIcon:Icon;
		private var clearIcon:Icon;
		private var dispatchOnTextChange:Boolean;
		public var searchField:JTextField;
		
		protected var searchPreferencesForm:Container;
		
		public function SearchPanel(searchPreferences:ISearchPreferences=null, dispatchOnTextChange:Boolean = false)
		{
			super(new FlowLayout());
			this.dispatchOnTextChange = dispatchOnTextChange;
			
			searchIcon = new AssetIcon(new SEARCH_ICON16, 20, 20);
			clearIcon = new AssetIcon(new SEARCH_ICON16, 20, 20);
			var path:String = "F:\\Projects\\projects\\flash\\studio\\Studio\\assets\\icons\\clear_icon20 копия.png";
			//clearIcon = new WatchingIcon(path);
			//clearSearchFieldBtn = new StateToggleButton("", clearIcon);
			
			if (searchPreferences){
				searchPreferencesForm = searchPreferences.getSearchPreferencesForm();
			}
			
			clearSearchFieldBtn = new JDropDownButton("", clearIcon, false, searchPreferencesForm);
			clearSearchFieldBtn.setPreferredWidth(32);
			clearSearchFieldBtn.setDisabledIcon(searchIcon);
			clearSearchFieldBtn.setBackgroundDecorator(null);
			clearSearchFieldBtn.addActionListener(clearSearchFieldBtnHandler);
			//clearSearchFieldBtn.setEnabled(false);
			
			searchField = new DSTextField();
			searchField.addEventListener(Event.CHANGE, onTextChange);
			searchField.setPreferredWidth(220);
			//searchField.setPreferredHeight(24);
			searchField.setPreferredHeight(20);
			searchField.addActionListener(searchFieldHandler);
			
			appendAll(searchField, clearSearchFieldBtn);
			
			searchField.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			searchField.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			clearSearchFieldBtn.alpha = 0.24;
		}
		
		private function onFocusOut(e:FocusEvent):void 
		{
			KTween.to(clearSearchFieldBtn, 0.25, {alpha: 0.24}, Linear.easeIn).init();
			/*if (v)
				{
					alpha = 0;
					super.setVisible(true);
					KTween.to(this, 0.15, {alpha: 1}, Linear.easeIn).init();
				}
				else
				{
					//super.setVisible(false);
					KTween.to(this, 0.08, {alpha: 0}, Linear.easeIn, onAlphaReduceComplete).init();
				}*/
		}
		
		private function onFocusIn(e:FocusEvent):void 
		{
			KTween.to(clearSearchFieldBtn, 0.25, {alpha: 0.5}, Linear.easeIn).init();
		}
		
		public function getSearchText():String{
			return searchField.getText();
		}
		
		public function setSearchText(text:String):void{
			searchField.setText(text);
		}
		
		private function searchFieldHandler(e:AWEvent):void 
		{
			super.dispatchEvent(new AWEvent(AWEvent.ACT));
		}
		
		private function clearSearchFieldBtnHandler(e:AWEvent):void 
		{
			searchField.setText("");
			onTextChange(null);
		}
		
		private function onTextChange(e:Event):void
		{
			//также нужно поменять слушателя - очистка поля или поиск
			
			if (searchField.getText()!="")
			clearSearchFieldBtn.setEnabled(true);
				//showSearchPreferencesBtn.setIcon(clearIcon);
			else
			clearSearchFieldBtn.setEnabled(false);
				//showSearchPreferencesBtn.setIcon(searchIcon);
			//showSearchPreferencesBtn.alpha = 1;
			
			if (dispatchOnTextChange) {
				super.dispatchEvent(new AWEvent(AWEvent.ACT));
			}
		}
		
		public function addActionListener(listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			super.addEventListener(AWEvent.ACT, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeActionListener(listener:Function):void
		{
			super.removeEventListener(AWEvent.ACT, listener);
		}
	
	}

}