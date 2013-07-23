<cfoutput>

	<p id="instructions">
		Does your XML suffer from "single-line-itus"? Paste it in the text box
		below and press the <strong>Beautify!</strong> button.
	</p>

	<textarea name="xmlString" id="xmlString" class="span8" rows="10"><records><record><firstName>Adam</firstName><lastName>Presley</lastName></record></records></textarea>

	<div class="clear"></div>
	<br />
	
	<button name="btnParse" id="btnParse" class="btn btn-primary">Beautify!</button>
	<button name="btnClear" id="btnClear" class="btn">Clear</button>

	<div class="clear"></div>

	<br style="margin-bottom: 2in;"></br>

	<div class="hide" id="resultsContainer">
		<hr />
		<h3>Results</h3>
		<div id="results"></div>

		<br style="margin-bottom: 2in;"></br>
	</div>

	<cfsavecontent variable="rc.js">

		var page = null;

		$(document).ready(function() {
			page = new CodeDaySpa.BeautifyXmlPage();
		});

	</cfsavecontent>

</cfoutput>