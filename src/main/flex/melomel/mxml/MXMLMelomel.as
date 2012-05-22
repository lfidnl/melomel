/*
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * @author Ben Johnson
 */
package melomel.mxml
{
import melomel.core.Bridge;
import melomel.errors.MelomelError;

import mx.core.IMXMLObject;
import mx.core.UIComponent;
import mx.events.FlexEvent;

import flash.events.EventDispatcher;

import flash.external.ExternalInterface;

/**
 *	This class allows you to automatically start up a Melomel bridge through
 *	MXML like this:
 *	
 *	<p><pre>
 *	&lt;m:Melomel/&gt;
 *	</pre></p>
 */
public class MXMLMelomel implements IMXMLObject
{
	//--------------------------------------------------------------------------
	//
	//	Constructor
	//
	//--------------------------------------------------------------------------

	/**
	 *	Constructor.
	 */
	public function MXMLMelomel()
	{
		super();
	}


	//--------------------------------------------------------------------------
	//
	//	Properties
	//
	//--------------------------------------------------------------------------

	/**
	 *	A flag stating if debugging should be enabled.
	 */
	public var debug:Boolean = false;

	/**
	 *	The hostname to connect to.
	 */
	public var host:String = "localhost";

	/**
	 *	The port to connect to on the host.
	 */
	public var port:int = 10101;


	//--------------------------------------------------------------------------
	//
	//	Methods
	//
	//--------------------------------------------------------------------------

	public function initialized(document:Object, id:String):void
	{
		// Wait until creation complete before we connect
		document.addEventListener(FlexEvent.CREATION_COMPLETE, function(event:FlexEvent):void{
			Melomel.debug = debug;
			Melomel.connect(host, port);
		});

    // Let reconnect Melomel to external interface with JavaScript in browser
    try
    {
      ExternalInterface.addCallback("reconnectMelomel", Melomel.reconnectMelomel);
    }
    catch(error:Error)
    {
			if (Melomel.debug) trace("Cannot add callback for reconnectMelomel method. May be Melomel ran for non-HTML application. Error message: " + error.message);
    }
	}
}
}
