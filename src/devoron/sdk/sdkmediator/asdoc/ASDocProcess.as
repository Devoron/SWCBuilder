package devoron.sdk.sdkmediator.asdoc
{
    import __AS3__.vec.*;
    import com.gskinner.data.*;
    import com.gskinner.events.*;
    import com.gskinner.model.*;
    import flash.desktop.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class ASDocProcess extends EventDispatcher
    {
        protected var process:NativeProcess;
        protected var data:ASDocModel;
        protected var currentConfig:ASDocConfig;
        protected var processError:Boolean;
        protected var processErrorOnComplete:Boolean;
        protected var manualStop:Boolean;
        protected var htmlOpened:Boolean;
        public var versionNum:String;

        public function ASDocProcess()
        {
            this.data = ModelLocator.getModel("data") as ASDocModel;
            return;
        }// end function

        public function start() : void
        {
            arguments = new activation;
            var l:int;
            var i:int;
            var arg:String;
            var packageList:Array;
            var params:String;
            var arguments:* = arguments;
            var file:* = this.checkExecutable(this.data.executablePath);
            if ( == null)
            {
                this.dispatchProcessError();
                return;
            }
            this.manualStop = false;
            this.htmlOpened = false;
            this.processError = false;
            this.processErrorOnComplete = false;
            var startupInfo:* = new NativeProcessStartupInfo();
            this.executable = ;
            if (this.process && this.process.running)
            {
                this.process.exit(true);
            }
            this.process = new NativeProcess();
            this.process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, this.handleStandardOutput, false, 0, true);
            this.process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, this.handleStandardError, false, 0, true);
            this.process.addEventListener(Event.STANDARD_OUTPUT_CLOSE, this.handleStandardOutputClose, false, 0, true);
            this.currentConfig = this.data.currentConfig;
            var args:* = new Vector.<String>;
            this.push("-source-path");
            if (this.currentConfig.sourceDirectory)
            {
                this.push(this.currentConfig.sourceDirectory);
            }
            else
            {
                this.push(".");
            }
            if (this.currentConfig.outputDirectory)
            {
                if (this.currentConfig.outputDirectory && this.currentConfig.clearOutputDir)
                {
                    file = new File("/" + this.currentConfig.outputDirectory);
                    if (this.exists)
                    {
                        this.deleteDirectory(true);
                    }
                }
                this.push("-output");
                this.push(this.currentConfig.outputDirectory);
            }
            if (this.currentConfig.sourceType == ASDocConfig.DOC_CLASSES && this.currentConfig.docClassList.replace(/ /g, "").length)
            {
                this.push("-doc-classes");
                this.addArgs(, this.splitOnSpaces(this.currentConfig.docClassList));
            }
            else
            {
                this.push("-doc-sources");
                l = this.currentConfig.docSourceList ? (this.currentConfig.docSourceList.length) : (0);
                i;
                while ( < )
                {
                    
                    this.push(this.currentConfig.docSourceList[]);
                    i = ( + 1);
                }
                if ( == 0)
                {
                    this.push(this.currentConfig.sourceDirectory);
                }
            }
            if (this.data.libraryPath.source)
            {
                l = this.data.libraryPath.source.length;
                i;
                while ( < )
                {
                    
                    this.push("-library-path+=<com.gskinner.DummyQuote>" + this.data.libraryPath.source[] + "<com.gskinner.DummyQuote>");
                    i = ( + 1);
                }
            }
            if (this.currentConfig.excludeClassList)
            {
                this.push("-exclude-classes");
                this.addArgs(, this.splitOnSpaces(this.currentConfig.excludeClassList));
            }
            if (this.currentConfig.excludeDependancies)
            {
                this.push("-exclude-dependencies=true");
            }
            if (this.currentConfig.htmlTitle)
            {
                this.push("-main-title");
                this.push(this.replaceSpecialChars(this.currentConfig.htmlTitle));
            }
            if (this.currentConfig.windowTitle)
            {
                this.push("-window-title");
                this.push(this.replaceSpecialChars(this.currentConfig.windowTitle));
            }
            if (this.currentConfig.footerText)
            {
                this.push("-footer");
                this.push(this.replaceSpecialChars(this.currentConfig.footerText));
            }
            if (this.currentConfig.templatesPath)
            {
                this.push("-templates-path");
                this.push(this.currentConfig.templatesPath);
            }
            if (this.currentConfig.packageList)
            {
                packageList = this.splitOnSpaces(this.currentConfig.packageList);
                l = this.length;
                if ( % 2 == 0)
                {
                    i;
                    while ( < )
                    {
                        
                        this.push("-package");
                        this.push(this.replaceSpecialChars(this[]));
                        i = ( + 1);
                        this.push(this.replaceSpecialChars(this[( + 1)]));
                        i = ( + 1);
                    }
                }
            }
            if (this.currentConfig.additionalParams)
            {
                params = this.replaceSpecialChars(this.currentConfig.additionalParams);
                this.addArgs(, this.splitOnSpaces());
            }
            if (!this.data.versionNum || this.data.versionNum.search("Version 4") != -1)
            {
                if (this.currentConfig.lenient)
                {
                    this.push("-lenient");
                }
            }
            if (this.currentConfig.strict)
            {
                this.push("-strict");
            }
            if (this.currentConfig.warnings && this.data.versionNum.search("Version 2") == -1)
            {
                this.push("-warnings");
            }
            var commandString:* = this.data.executablePath.replace(".exe", "") + " ";
            var argumentNum:* = this.length;
            i;
            while ( < )
            {
                
                arg = this[];
                if (this.charAt(0) != "-")
                {
                    arg = "\"" + this[] + "\"";
                    this.replace(/&/g, "&amp;");
                }
                arg = this.replace(/<com.gskinner.DummyQuote>/g, "\"");
                commandString =  + ( + " ");
                i = ( + 1);
            }
            commandString =  + "\r\r";
            i;
            while ( < )
            {
                
                this[] = this[].replace(/<com.gskinner.DummyQuote>/g, "");
                i = ( + 1);
            }
            this.arguments = ;
            try
            {
                if (this.executable.name == "asdoc" || this.executable.name == "asdoc.exe")
                {
                    this.process.start();
                }
            }
            catch (error:Error)
            {
                gtrace("Error: " + error.toString());
            }
            if (!this.process.running)
            {
                this.dispatchProcessError();
            }
            else
            {
                dispatchEvent(new ProcessEvent(ProcessEvent.STARTED, {message:}));
            }
            return;
        }// end function

        public function checkVersion() : void
        {
            arguments = new activation;
            var arguments:* = arguments;
            var file:* = this.checkExecutable(this.data.executablePath);
            if ( == null)
            {
                return;
            }
            var startupInfo:* = new NativeProcessStartupInfo();
            this.executable = ;
            if (this.process && this.process.running)
            {
                this.process.exit(true);
            }
            this.process = new NativeProcess();
            this.process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, this.handleVersionOutput, false, 0, true);
            var args:* = new Vector.<String>;
            this.push("-version");
            this.arguments = ;
            try
            {
                this.process.start();
            }
            catch (error:Error)
            {
                dispatchEvent(new ProcessEvent(ProcessEvent.VERSION, {versionNum:null}));
                gtrace("Error: " + error.toString());
            }
            return;
        }// end function

        public function checkExecutable(param1:String) : File
        {
            var _loc_2:* = new File("/" + param1);
            if (_loc_2.exists && (_loc_2.name == "asdoc.exe" || _loc_2.name == "asdoc"))
            {
                return _loc_2;
            }
            return null;
        }// end function

        public function stop() : void
        {
            if (this.process && this.process.running)
            {
                this.process.exit(true);
                this.manualStop = true;
            }
            return;
        }// end function

        protected function dispatchProcessError() : void
        {
            dispatchEvent(new ProcessEvent(ProcessEvent.ERROR, {title:"Error", text:"Process could not be started. Check your asdoc executable to make sure it\'s not corrupted."}));
            return;
        }// end function

        protected function handleVersionOutput(event:ProgressEvent) : void
        {
            var _loc_2:* = (event.target as NativeProcess).standardOutput;
            var _loc_3:* = this.parseStandardInput(_loc_2.readUTFBytes(_loc_2.bytesAvailable));
            if (_loc_3.search("Version") != -1)
            {
                this.versionNum = _loc_3;
                dispatchEvent(new ProcessEvent(ProcessEvent.VERSION, {versionNum:this.versionNum}));
            }
            this.process.exit();
            return;
        }// end function

        protected function handleStandardOutput(event:ProgressEvent) : void
        {
            var _loc_2:* = (event.target as NativeProcess).standardOutput;
            var _loc_3:* = this.parseStandardInput(_loc_2.readUTFBytes(_loc_2.bytesAvailable));
            dispatchEvent(new ProcessEvent(ProcessEvent.STANDARD_UPDATE, {message:_loc_3}));
            if (_loc_3.search("Encountered too many errors!") == -1)
            {
                this.processErrorOnComplete = false;
            }
            return;
        }// end function

        protected function handleStandardError(event:ProgressEvent) : void
        {
            var _loc_2:* = (event.target as NativeProcess).standardError;
            var _loc_3:* = this.parseStandardInput(_loc_2.readUTFBytes(_loc_2.bytesAvailable));
            dispatchEvent(new ProcessEvent(ProcessEvent.STANDARD_ERROR, {message:_loc_3}));
            this.processError = true;
            this.processErrorOnComplete = true;
            return;
        }// end function

        protected function handleStandardOutputClose(event:Event) : void
        {
            var _loc_2:* = true;
            if (!this.processErrorOnComplete && this.processError)
            {
                dispatchEvent(new ProcessEvent(ProcessEvent.COMPLETED_WITH_ERRORS, {errors:true}));
            }
            else if (!this.processError)
            {
                dispatchEvent(new ProcessEvent(ProcessEvent.COMPLETED, {errors:false}));
            }
            else
            {
                _loc_2 = false;
                dispatchEvent(new ProcessEvent(ProcessEvent.FAILED));
            }
            this.process.removeEventListener(Event.STANDARD_OUTPUT_CLOSE, this.handleStandardOutputClose);
            this.process.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, this.handleStandardOutput);
            this.process.removeEventListener(ProgressEvent.STANDARD_ERROR_DATA, this.handleStandardError);
            return;
        }// end function

        protected function splitOnSpaces(param1:String) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = "";
            var _loc_4:* = 0;
            param1 = param1.replace(/\\"/g, "<com.gskinner.EQ>");
            var _loc_5:* = 0;
            while (_loc_5 < param1.length)
            {
                
                _loc_3 = param1.charAt(_loc_5);
                if (_loc_3 == "\"")
                {
                    _loc_4++;
                }
                _loc_2 = _loc_2 + (_loc_3 == " " && _loc_4 % 2 == 0 ? ("<com.gskinner.BR>") : (_loc_3));
                _loc_5++;
            }
            _loc_2 = _loc_2.replace(/\"/g, "");
            _loc_2 = _loc_2.replace(/(\<com\.gskinner\.BR\>)+/g, "<com.gskinner.BR>");
            _loc_2 = _loc_2.replace(/<com.gskinner.EQ>/g, "\"");
            return _loc_2.split("<com.gskinner.BR>");
        }// end function

        protected function addArgs(param1:Vector.<String>, param2:Array) : void
        {
            var _loc_3:* = param2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                param1.push(param2[_loc_4]);
                _loc_4++;
            }
            return;
        }// end function

        protected function replaceSpecialChars(param1:String) : String
        {
            param1 = param1.replace(/&/g, "&amp;");
            param1 = param1.replace(/</g, "&lt;");
            param1 = param1.replace(/>/g, "&gt;");
            return param1;
        }// end function

        protected function parseStandardInput(param1:String) : String
        {
            return param1;
        }// end function

        protected function parseErrors(param1:String) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_2:* = param1.split(/\n\r|\n|\r/);
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = [];
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = _loc_2[_loc_5] as String;
                if (_loc_6.match(/^\/|c:/i))
                {
                    _loc_7 = _loc_6.indexOf("(");
                    _loc_8 = _loc_6.slice(0, _loc_7);
                    _loc_9 = _loc_6.slice(_loc_7);
                    _loc_4.push({path:_loc_8, error:"Line: " + _loc_9});
                }
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
