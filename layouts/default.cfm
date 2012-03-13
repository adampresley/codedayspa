<cfoutput><!DOCTYPE html>
<html lang="en">
<head>
	<title><cfif structKeyExists(rc, "title")>#rc.title#<cfelse>Home</cfif> // Code Day-Spa</title> 
	<meta charset="utf-8" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="A day spa for code and coders" />
	<meta name="author" content="Adam Presley" />

	<link rel="stylesheet" type="text/css" href="/resources/css/cerulean.min.css" />
	<link rel="stylesheet" type="text/css" href="/resources/css/codedayspa.css" />

	<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
		<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->

	<!-- Le fav and touch icons -->
	<link rel="shortcut icon" href="/favicon.ico" />

   <!--- ${jsScriptIncludes:start} --->
   <script src="/resources/js/jquery/jquery-1.7.1.js"></script>
	<script src="/resources/js/bootstrap/bootstrap-transition.js"></script>
	<script src="/resources/js/bootstrap/bootstrap-alert.js"></script>
	<script src="/resources/js/bootstrap/bootstrap-modal.js"></script>
	<script src="/resources/js/bootstrap/bootstrap-dropdown.js"></script>
	<script src="/resources/js/bootstrap/bootstrap-scrollspy.js"></script>
	<script src="/resources/js/bootstrap/bootstrap-tab.js"></script>
	<script src="/resources/js/bootstrap/bootstrap-tooltip.js"></script>
	<script src="/resources/js/bootstrap/bootstrap-popover.js"></script>
	<script src="/resources/js/bootstrap/bootstrap-button.js"></script>
	<script src="/resources/js/bootstrap/bootstrap-collapse.js"></script>
	<script src="/resources/js/bootstrap/bootstrap-carousel.js"></script>
	<script src="/resources/js/bootstrap/bootstrap-typeahead.js"></script>
	<script src="/resources/js/jquery/blockui.js"></script>
	<script src="/resources/js/jquery/jquery.tmpl.min.js"></script>

	<script src="/resources/js/BootstrapPlus.js"></script>	
	<script src="/resources/js/adampresley.js"></script>
	<!--- ${jsScriptIncludes:end} --->
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
		</footer>
	</div> <!-- /.fluid-container -->
    
	<script src="/resources/js/codedayspa.js"></script>
<body>
</html></cfoutput>