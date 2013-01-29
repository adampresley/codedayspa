CodeDaySpa = {
	BeautifyJsonPage: { },
	BeautifyWsdlPage: { },

	ajax: function(config) {
		var
			data = $.extend(config.data, { method: "process" });

		config = $.extend({
			dataType: "json",
			data: data,
			url: "/ajaxProxy.cfc",
			type: "POST"
		}, config);

		$.ajax(config);
	},

	block: function(msg, el) {
		if (el !== undefined) {
			$(el).blockUI({ message: "<h3><img src=\"/resources/images/ajax-loader.gif\" style=\"padding-top: 10px; padding-right: 10px;\" /> " + msg + "</h3>" });
		}
		else {
			$.blockUI({ message: "<h3><img src=\"/resources/images/ajax-loader.gif\" style=\"padding-top: 10px; padding-right: 10px;\" /> " + msg + "</h3>" });
		}
	},

	unblock: function(el) {
		if (el !== undefined) {
			$(el).unblockUI();
		}
		else {
			$.unblockUI();
		}
	},

	showAjaxError: function(xhr, callback) {
		var r = $.trim(xhr.responseText);
		var parsed = $.parseJSON(r);

		CodeDaySpa.unblock();

		if (parsed !== null && parsed !== undefined && "message" in parsed) {
			new BootstrapPlus.Modal({
				header: "Error",
				body: "<p>" + parsed.message + "</p>"
			});
		}
	},

	error: function(message, header) {
		CodeDaySpa.unblock();
		new BootstrapPlus.Modal({
			header: header || "Notice",
			body: "<p>" + message + "</p>",
			events: {
				hidden: function() { $("#jsonString").focus(); }
			}
		});
	}
};


CodeDaySpa.BeautifyJsonPage = function(config) {
	var
		__init = function() {
			$("#btnParse").on("click", __parse);
			$("#btnClear").on("click", __clear);

			$("#jsonString").focus()
		},

		__parse = function() {
			if ($.trim($("#jsonString").val()) === "" && $.trim($("#jsonUrl").val()) === "") {
				new BootstrapPlus.Modal({
					header: "Error",
					body: "<p>You must provide *some* JSON... or at least a URL with some JSON...</p>"
				});
				return;
			}

			CodeDaySpa.block("Beautifying JSON...");

			if ($("#chkGridResults").attr("checked") && $.trim($("#jsonUrl").val()) === "") {
				__onParseSuccess({ output: $("#jsonString").val() });
			}
			else {
				CodeDaySpa.ajax({
					data: {
						action: "beautify.json",
						jsonString: $("#jsonString").val(),
						jsonUrl: $("#jsonUrl").val(),
						grid: (($("#chkGridResults").attr("checked")) ? true : false)
					},
					success: __onParseSuccess,
					error: __onParseError
				});
			}
		},

		__onParseSuccess = function(response) {
			var 
				data = response.output,
				rendered = null,
				item = null,
				index = 0,
				parsed = [],
				e;
			
			if ($("#chkGridResults").attr("checked")) {
				try {
					data = $.parseJSON(data);

					if (data.hasOwnProperty("length") && data.length > 0) {
						rendered = '<table class="table table-striped table-bordered table-condensed"><thead><tr>';

						for (item in data[0]) {
							rendered += '<th>' + item + "</th>";
						}

						rendered += '</tr></thead><tbody>';

						for (index = 0; index < data.length; index++) {
							rendered += '<tr>';

							for (item in data[index]) {
								rendered += '<td>' + data[index][item] + '</td>';
							}

							rendered += '</tr>';
						}

						rendered += '</tbody></table>';
					} else {
						CodeDaySpa.error("To show results as a grid the JSON data must start with an Array object.");
					}
				}
				catch (e) {
					CodeDaySpa.showAjaxError({ responseText: "{ \"message\": \"There was a problem Beautifying your JSON. Perhaps a syntax/validation issue?\" }" });
					rendered = "<p>No results to beautify. Did you make sure that your data was an array?</p>";
				}
			}
			else {
				rendered = data;
			}

			$("#results").html(rendered);
			window.prettyPrint();
			
			$("#resultsContainer").show();

			$("html, body").animate({ scrollTop: $("#results").offset().top - 75 }, 1000);
			CodeDaySpa.unblock();
		},

		__onParseError = function(xhr) {
			CodeDaySpa.showAjaxError(xhr);
		},

		__clear = function() {
			$("#resultsContainer").fadeOut("slow", function() {
				$("#results").html("");
				$("html, body").animate({
					scrollTop: $("#instructions").offset().top
				}, 1000);
			});
		},

		__this = this,
		__config = $.extend(config, {});

	__init();
};
YAOF.attach(CodeDaySpa.BeautifyJsonPage);


CodeDaySpa.BeautifyWsdlPage = function(config) {
	var
		__init = function() {
			$("#btnParse").on("click", __parse);
			$("#btnClear").on("click", __clear);

			$("#wsdlUrl").focus();
		},

		__parse = function() {
			if ($.trim($("#wsdlUrl").val()) === "") {
				new BootstrapPlus.Modal({
					header: "Error",
					body: "<p>You must provide a URL with a WSDL document...</p>"
				});
				return;
			}

			CodeDaySpa.block("Beautifying WSDL...");

			CodeDaySpa.ajax({
				data: {
					action: "beautify.wsdl",
					wsdlUrl: $("#wsdlUrl").val()
				},
				success: __onParseSuccess,
				error: __onParseError
			});
		},

		__onParseSuccess = function(response, evalResponse) {
			$("#results").html(response.output);
			$("#resultsContainer").show();

			$("html, body").animate({ scrollTop: $("#results").offset().top - 75 }, 1000);
			CodeDaySpa.unblock();
		},

		__onParseError = function(xhr) {
			CodeDaySpa.showAjaxError(xhr);
		},

		__clear = function() {
			$("#resultsContainer").fadeOut("slow", function() {
				$("#results").html("");
				$("html, body").animate({
					scrollTop: $("#instructions").offset().top
				}, 1000);
			});
		},

		__this = this,
		__config = $.extend(config, {});

	__init();
};
YAOF.attach(CodeDaySpa.BeautifyWsdlPage);


CodeDaySpa.BeautifySqlPage = function(config) {
	var
		__init = function() {
			$("#btnParse").on("click", __parse);
			$("#btnClear").on("click", __clear);

			$("#sqlString").focus()
		},

		__parse = function() {
			if ($.trim($("#sqlString").val()) === "") {
				new BootstrapPlus.Modal({
					header: "Error",
					body: "<p>You must provide *some* SQL...</p>"
				});
				return;
			}

			CodeDaySpa.block("Beautifying SQL...");

			CodeDaySpa.ajax({
				data: {
					action: "beautify.sql",
					sqlString: $("#sqlString").val()
				},
				success: __onParseSuccess,
				error: __onParseError
			});
		},

		__onParseSuccess = function(response) {
			$("#results").html(response.output);
			window.prettyPrint();

			$("#resultsContainer").show();

			$("html, body").animate({ scrollTop: $("#results").offset().top - 75 }, 1000);
			CodeDaySpa.unblock();
		},

		__onParseError = function(xhr) {
			CodeDaySpa.showAjaxError(xhr);
		},

		__clear = function() {
			$("#resultsContainer").fadeOut("slow", function() {
				$("#results").html("");
				$("html, body").animate({
					scrollTop: $("#instructions").offset().top
				}, 1000);
			});
		},

		__this = this,
		__config = $.extend(config, {});

	__init();	
};
YAOF.attach(CodeDaySpa.BeautifySqlPage);
