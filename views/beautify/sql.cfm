<cfoutput>

	<p id="instructions">
		Is your SQL unstructured and unruly? Coworker send you a particularly
		nasty query that you'd like to polish? Paste it into the text area below
		and press the <strong>Beautify!</strong> button.
	</p>

	<textarea name="sqlString" id="sqlString" class="span8" rows="10">select a.a, a.b, a.c from a where 1=1 and a.a=2 and (a.b > 1 or a.c != 10)</textarea>

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
			page = new CodeDaySpa.BeautifySqlPage();
		});

	</cfsavecontent>

</cfoutput>