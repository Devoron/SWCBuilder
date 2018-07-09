package devoron.aslc.moduls.project
{
	import devoron.dataui.multicontainers.table.DataContainersForm;
	import devoron.dataui.multicontainers.table.ContainersAssetsControlPanel;
	import devoron.components.buttons.AboutButton;
	import devoron.components.icons.WatchingIcon;
	import devoron.components.labels.DSLabel;
	import flash.events.IEventDispatcher;
	import net.kawa.tween.easing.Linear;
	import net.kawa.tween.KTween;
	import org.aswing.ASColor;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.Icon;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.layout.GridLayout;
	
	/**
	 * TargetPlatformsOptionPane
	 * @author Devoron
	 */
	public class TargetPlatformsOptionPane extends JPanel implements IEventDispatcher
	{
		
		public function TargetPlatformsOptionPane()
		{
			super(new GridLayout(0, 2, 10, 5));
			/*projectTypesBG = new ButtonGroup;
			   createTargetPlatformOptionPane();
			 projectTypesBG.setSelectedIndex(0);*/
			installComponents();
		}
		
		protected function installComponents():void
		{
			var path:String = "F:\\Projects\\projects\\flash\\studio\\Studio\\assets\\icons\\NewProjectForm\\flash_player_icon24.png";
			var path2:String = "F:\\Projects\\projects\\flash\\studio\\Studio\\assets\\icons\\NewProjectForm\\adobe_air_icon24.png";
			var path3:String = "F:\\Projects\\projects\\flash\\studio\\Studio\\assets\\icons\\NewProjectForm\\swc_icon24.png";
			addOption("Flash Player AS3", "player", new WatchingIcon(path, 24, 24));
			addOption("Flash AIR AS3", "air", new WatchingIcon(path2, 24, 24));
			addOption("AS3 Library SWC", "swc", new WatchingIcon(path3, 24, 24));
			//addOption("AIR Mobile AS3 Application", "air_mobile", new AssetIcon(new FLASH_PLAYER_ICON24, 24, 24));
			//addOption("AIR Mobile AS3 Application", "air_oculus", new AssetIcon(new FLASH_PLAYER_ICON24, 24, 24));
			//addOption("Server-side AS3", "server", new AssetIcon(new FLASH_PLAYER_ICON24, 24, 24));
		}
		
		private function addOption(text:String, name:String, icon:Icon):void
		{
			//var rb:JRadioButton = new JRadioButton(text, icon);
			//var rb:JToggleButton = new JToggleButton(text, icon);
			var rb:AboutButton = new AboutButton(text);
			//
			rb.setAlpha(0.6);
			rb.setIcon(icon);
			rb.setPreferredWidth(180);
			rb.setPreferredHeight(24);
			rb.setIconTextGap(4);
			rb.setHorizontalAlignment(JLabel.LEFT);
			//projectTypesBG.append(rb);
			rb.setName(name);
			//tablePane.addRow();
			rb.setForeground(new ASColor(0xFFFFFF, 0.4));
			//if (projectTypesBG.getButtonCount() == 1)
			//{
				//tablePane.addLabel("Project Target");
				
				//if (!containersControlPanel2)
				//{
					//containersControlPanel2 = new ContainersAssetsControlPanel("Project template");
					//containersControlPanel2.setPreferredWidth(80);
					//containersControlPanel2.setPreferredHeight(22);
					//containersControlPanel.addIContentViewListener(contentChange);
					//containersControlPanel.addActionListener(selectContentViewListener);
					//(containersControlPanel as ContainersAssetsControlPanel).selectedLB.addActionListener(showContainersTableBtnHandler);
					//var dcf:DataContainersForm = new DataContainersForm()
					//tablePane.addCell(dcf.getContentPane());
					/*addLeftHoldRow(0, [0, 20]);
					addLeftHoldRow(0, new DSLabel("template"));
					addLeftHoldRow(0, dcf.getContentPane());*/
				//}
				//
				//includeLibrariesForm.addRightHoldRow(0, containersControlPanel.getControlPanel());
				
				//addLabel(text:String, constraints:int = 136, colspan:int = 1)
				
				//containersControlPanel2.getCell
				//containersControlPanel2.get
				//tablePane.addCell(containersControlPanel2.dcf);
				
				//tablePane.addCell(containersControlPanel2.getControlPanel());
				//tablePane.addCell(null);
				//tablePane.addCell(null);
				/* tablePane.addCell(null);
				   tablePane.addCell(null);
				 tablePane.addCell(null);*/
				//tablePane.addRow();
				//rb.setSelected(true); //default first
			//}
			//else
			//tablePane.addCell(null);
			
			append(rb);
			//tablePane.addCell(rb, TablePane.ALIGN_LEFT);
			//rb.addActionListener(onAct);
			rb.addStateListener(onState);
		}
		
		private function onState(e:InteractiveEvent):void
		{
			KTween.to((e.target as AboutButton), (e.target as AboutButton).isSelected() ? 0.35 : 0.25, {alpha: (e.target as AboutButton).isSelected() ? 0.9 : 0.6}, Linear.easeIn).init();
		}
	
	}

}