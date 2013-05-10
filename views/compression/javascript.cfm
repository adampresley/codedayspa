<cfoutput>

	<p id="instructions">
		Does your JavaScript suffer from bloat? Do you feel like it is
		retaining water? A little compression therapy can go a long way.
		Paste your code in the text box below and press the <strong>Compress!</strong>
		button.
	</p>

	<textarea name="jsString" id="jsString" class="span8" rows="10">var name = "Adam";
alert(name);</textarea>

	<div class="clear"></div>
	<br />
	
	<button name="btnParse" id="btnParse" class="btn btn-primary">Compress!</button>
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
			page = new CodeDaySpa.CompressJavaScriptPage();
		});

	</cfsavecontent>

</cfoutput>