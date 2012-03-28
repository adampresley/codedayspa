<cfoutput>

	<p id="instructions">
		Does your JSON need a little clean up?  Got a response back from an 
		AJAX call and you can barely read it? Just paste it in the text box
		below, or provide the URL in the box labelled <em>URL</em> and press the
		<strong>Beautify!</strong> button.
	</p>

	<textarea name="jsonString" id="jsonString" class="span8" rows="10">[{test:1,firstname:"Adam",lastname:"Presley"},{test:1,firstname:"Maryanne",lastname:"Presley"}]</textarea>

	<div class="clear"></div>
	<br />
	
	or <strong>URL:</strong> <input type="text" id="jsonUrl" value="" class="span6" />
	<div class="clear"></div>
	<br />

	<button name="btnParse" id="btnParse" class="btn btn-primary">Beautify!</button>
	<button name="btnClear" id="btnClear" class="btn">Clear</button>

	<div class="clear"></div>

	<br />
	<input type="checkbox" id="chkGridResults" value="" /> Results as Grid <small>(data must be an array of objects)</small><br />

	<br style="margin-bottom: 2in;"></br>

	<div class="hide" id="resultsContainer">
		<hr />
		<h3>Results</h3>
		<div id="results"></div>

		<br style="margin-bottom: 2in;"></br>
	</div>

	<script>

		var page = null;

		(function($) {
			$(document).ready(function() {
				page = new CodeDaySpa.BeautifyJsonPage();
			});
		})(jQuery);

	</script>

</cfoutput>