<cfoutput><!DOCTYPE html>
<html lang="en">
<head>
	<title><cfif structKeyExists(rc, "title")>#rc.title#<cfelse>Home</cfif> // Code Day-Spa</title> 
	<meta charset="utf-8" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="A day spa for code and coders" />
	<meta name="author" content="Adam Presley" />

	<!--- @cssIncludes@ --->
	<link rel="stylesheet" type="text/css" href="/resources/css/cerulean.min.css" />
	<link rel="stylesheet" type="text/css" href="/resources/css/bootstrap-responsive.css" />
	<link rel="stylesheet" type="text/css" href="/resources/css/codedayspa.css" />
	<!--- @cssIncludes@ --->

	<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
		<script src="/resources/js/html5.js"></script>
	<![endif]-->

	<!-- Le fav and touch icons -->
	<link rel="shortcut icon" href="/favicon.ico" />
</head>

<body>

	<div class="navbar navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</a>
			
				<a class="brand" href="/">Code Day-Spa</a>

				<div class="nav-collapse">
					<ul class="nav">
						<li<cfif request.context.section EQ "main"> class="active"</cfif>><a href="/">Home</a></li>
						<li class="dropdown <cfif request.context.section EQ 'beautify'> active</cfif>" id="beautifyMenu">
							<a href="##beautifyMenu" class="dropdown-toggle" data-toggle="dropdown">Beautify <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="#buildUrl('beautify.json')#">JSON</a></li>
								<li><a href="#buildUrl('beautify.wsdl')#">WSDL</a></li>
								<li><a href="#buildUrl('beautify.sql')#">SQL</a></li>
							</ul>
						</li>
						<li class="dropdown <cfif request.context.section EQ 'lounge'> active</cfif>" id="loungeMenu">
							<a href="##loungeMenu" class="dropdown-toggle" data-toggle="dropdown">SOA Lounge <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="#buildUrl('lounge.rest')#">REST</a></li>
								<li><a href="#buildUrl('lounge.webservice')#">Webservice</a></li>
							</ul>
						</li>
					</ul>
				</div> <!-- /.nav-collapse -->
			</div> <!-- /.container-fluid -->
		</div> <!-- /.navbar-inner -->
	</div> <!-- /.navbar -->

	<div class="container-fluid">
		<div class="row-fluid">
			<header class="jumbotron subhead">
				<cfif structKeyExists(rc, "title") && request.context.section NEQ "main"><h1>#rc.title#</h1></cfif>
			</header>

			<div class="span11">#body#</div>
		</div> <!-- /row -->

		<hr />

		<footer>
			<p>&copy; #dateFormat(now(), "yyyy")# Adam Presley</p>
			<p>This project is open source with code hosted on <a href="https://github.com/adampresley/codedayspa" target="_blank">GitHub.com</a>.</p>
			<p>
				Hosted using <a href="http://jelastic.com/" target="_blank">Jelastic</a> <em>"Java in the Cloud"</em> hosting. Run on <a href="http://tomcat.apache.org" target="_blank">Tomcat 7</a>, Java 6, and 
				<a href="http://openbd.org" target="_blank">OpenBD</a>.
		</footer>
	</div> <!-- /.fluid-container -->
    
   <!--- @jsScriptIncludes@ --->
   <script src="/resources/js/jquery-1.7.1.js"></script>
	<script src="/resources/js/bootstrap-transition.js"></script>
	<script src="/resources/js/bootstrap-alert.js"></script>
	<script src="/resources/js/bootstrap-modal.js"></script>
	<script src="/resources/js/bootstrap-dropdown.js"></script>
	<script src="/resources/js/bootstrap-scrollspy.js"></script>
	<script src="/resources/js/bootstrap-tab.js"></script>
	<script src="/resources/js/bootstrap-tooltip.js"></script>
	<script src="/resources/js/bootstrap-popover.js"></script>
	<script src="/resources/js/bootstrap-button.js"></script>
	<script src="/resources/js/bootstrap-collapse.js"></script>
	<script src="/resources/js/bootstrap-carousel.js"></script>
	<script src="/resources/js/bootstrap-typeahead.js"></script>
	<script src="/resources/js/blockui.js"></script>

	<script src="/resources/js/BootstrapPlus.js"></script>
	<script src="/resources/js/YAOF.min.js"></script>
	<script src="/resources/js/codedayspa.js"></script>
	<!--- @jsScriptIncludes@ --->

	<cfif structKeyExists(rc, "js")>
		<script type="text/javascript">#rc.js#</script>
	</cfif>

	<cfif cgi.server_name CONTAINS "codedayspa.com">
		<script type="text/javascript">

			var _gaq = _gaq || [];
			_gaq.push(['_setAccount', 'UA-30469718-1']);
			_gaq.push(['_setDomainName', 'codedayspa.com']);
			_gaq.push(['_trackPageview']);

			(function() {
				var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
				ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
				var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
			})();

		</script>
	</cfif>
</body>
</html></cfoutput>