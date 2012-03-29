<cfoutput>

	<p id="instructions">
		WSDL getting out of hand? Wish to turn that out-of-hand web service XML into 
		something more readable than ancient hieroglyphics? Just provide the URL in the box
		labelled <em>URL</em> and press the <strong>Beautify!</strong> button.
	</p>

	<strong>URL:</strong> <input type="text" id="wsdlUrl" value="http://www.webservicex.net/CurrencyConvertor.asmx?WSDL" class="span6" />
	<div class="clear"></div>
	<br />

	<button name="btnParse" id="btnParse" class="btn btn-primary">Beautify!</button>
	<button name="btnClear" id="btnClear" class="btn">Clear</button>

	<div class="clear"></div>
	<br style="margin-bottom: 2in;"><br />

	<div class="hide" id="resultsContainer">
		<hr />
		<div id="results"></div>

		<br style="margin-bottom: 2in;"></br>
	</div>

	<cfsavecontent variable="rc.js">

		var page = null;

		$(document).ready(function() {
			page = new CodeDaySpa.BeautifyWsdlPage();
		});

	</cfsavecontent>

</cfoutput>
