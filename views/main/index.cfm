<cfoutput>

	<div class="hero-unit">
		<h1>Code Day-Spa</h1>
		<p>Pamper your code</p>
	</div>

	<section class="margin-bottom-25">
		<p>
			<img src="/resources/images/candles-and-flowers.jpg" class="pull-right margin-left-25 inner-blur-shadow" />
			Welcome to the Code Day-Spa, a place where you can pamper and beautify your code.
			We offering a whole range of services free of charge. Wish you could clean up that
			JSON response? Perhaps wash away the grime from your WSDL file? No problem.
			Feeling a little more social? Head on over to the SOA Lounge for a little
			REST or Webservice action today!
		</p>
	</section>	

	<section class="margin-bottom-25 pull-left" style="width: 25%;">
		<h3>Beautify</h3>

		<ul>
			<li><a href="#buildUrl('beautify.json')#">Beautify JSON</a></li>
			<li><a href="#buildUrl('beautify.wsdl')#">Beautify WSDL</a></li>
		</ul>
	</section>

	<section class="margin-bottom-25 pull-left" style="width: 25%;">
		<h3>Lounge</h3>

		<ul>
			<li><a href="#buildUrl('lounge.rest')#">REST lounge</a></li>
			<li><a href="#buildUrl('lounge.webservice')#">Webservice lounge</a></li>
		</ul>
	</section>

	<div class="clear"></div>
	
</cfoutput>