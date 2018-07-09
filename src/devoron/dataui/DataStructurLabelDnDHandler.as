package devoron.dataui
{
	import devoron.components.pcfs.PathChooserForm;
	import devoron.components.data.DataContainerTitleBar;
	import devoron.components.FrameHelper;
	import devoron.data.core.base.DataStructur;
	import devoron.studio.core.scenebrowser.SceneBrowser;
	import org.aswing.Component;
	import org.aswing.Container;
	import org.aswing.dnd.DragListener;
	import org.aswing.dnd.DragManager;
	import org.aswing.dnd.RejectedMotion;
	import org.aswing.event.DragAndDropEvent;
	import org.aswing.ext.Form;
	import devoron.utils.searchandreplace.workers.SearchAndReplaceWorker.src.devoron.file.FileInfo;
	
	public class DataStructurLabelDnDHandler implements DragListener
	{
		private var sceneBrowser:SceneBrowser;
		
		public function DataStructurLabelDnDHandler(sceneBrowser:SceneBrowser){
			this.sceneBrowser = sceneBrowser;
			
		}
		
		public function onDragStart(e:DragAndDropEvent):void
		{
		}
		
		public function onDragEnter(e:DragAndDropEvent):void
		{
		}
		
		public function onDragOverring(e:DragAndDropEvent):void
		{
		}
		
		public function onDragExit(e:DragAndDropEvent):void
		{
		}
		
		public function onDragDrop(e:DragAndDropEvent):void
		{
			var targetComponent:Component = e.getTargetComponent();
			var dragInitiator:Component = e.getDragInitiator();
			var fr:Container;
			
			
			if (!targetComponent){
				DragManager.setDropMotion(new RejectedMotion());
				return;
			}
			if (targetComponent.isDragAcceptableInitiator(dragInitiator))
			{
				gtrace("gtht");
				//gtrace("Name " + dragInitiator.getParent().getParent().getParent().getParent().getParent().name);
				
				sceneBrowser.addDataStructur2(dragInitiator.metaData as DataStructur);
				/*fr = dragInitiator.metaData as Container;
				
				fr.getParent().getParent().removeFromContainer();
				(targetComponent as Form).addLeftHoldRow(0, fr);
				(targetComponent as Form).updateUI();*/
				
				
				// теперь из этой структуры данных необходимо создать новую и добавить её в SceneBrowser
				
					//fr.getParent().remove(fr);
					//var modulForm:Container = dragInitiator.getParent().getParent().getParent().getParent().getParent().getParent();
					//modulForm.remove(fr.getParent());
				
				/*var сt:Container = Container(targetComponent);
				   dragInitiator.removeFromContainer();
				   сt.append(dragInitiator);
				 сt.removeDragAcceptableInitiator(dragInitiator);*/ /*if (targetComponent is PathChooserForm) {
				   var fi:FileInfo = e.getSourceData().getData() as FileInfo;
				   (targetComponent as PathChooserForm).setPath(fi.nativePath);
				 }*/
			}
			else
			{
				DragManager.setDropMotion(new RejectedMotion());
				//fr = dragInitiator.metaData as Container;
				
				//fr.getParent().getParent().removeFromContainer();
				//(targetComponent as Form).addLeftHoldRow(0, fr);
				//(targetComponent as Form).updateUI();
				//DragManager.setDropMotion(new RejectedMotion());
				//FrameHelper.toInternalFrame(fr);
				
			}
		}
	}
}