CodeDaySpa = {
	BeautifyJsonPage: { },

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
	}
};


CodeDaySpa.BeautifyJsonPage = function(config) {
	var
		__init = function() {
			$("#btnParse").on("click", __parse);
			$("#btnClear").on("click", __clear);
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
				__onParseSuccess($("#jsonString").val(), false);
			}
			else {
				$.ajax({
					url: "/ajaxProxy.cfc?method=process",
					data: {
						action: "beautify.json",
						jsonString: $("#jsonString").val(),
						jsonUrl: $("#jsonUrl").val(),
						grid: (($("#chkGridResults").attr("checked")) ? true : false)
					},
					type: "POST",
					dataType: "json",
					success: __onParseSuccess,
					error: __onParseError
				});
			}
		},

		__onParseSuccess = function(response, evalResponse) {
			var 
				data = response.output,
				rendered = null,
				item = null,
				index = 0,
				parsed = [],
				e;
			
			if (evalResponse) {
				try {
					parsed = eval("(" + response + ")");
				}
				catch (e) {
					CodeDaySpa.unblock();
					new BootstrapPlus.Modal({
						header: "Error",
						body: "<p>We are sorry, but something went wrong during the beautification process. Please try again</p>"
					});

					return;
				}
			}

			if ($("#chkGridResults").attr("checked")) {
				if (parsed.output) {
					parsed = parsed.output;
				}
				
				if (parsed.length > 0) {
					rendered = '<table class="table table-striped table-bordered table-condensed"><thead><tr>';

					for (item in parsed[0]) {
						rendered += '<th>' + item + "</th>";
					}

					rendered += '</tr></thead><tbody>';

					for (index = 0; index < parsed.length; index++) {
						rendered += '<tr>';

						for (item in parsed[index]) {
							rendered += '<td>' + parsed[index][item] + '</td>';
						}

						rendered += '</tr>';
					}

					rendered += '</tbody></table>';
				}
				else {
					rendered = "<p>No results to beautify. Did you make sure that your data was an array?</p>";
				}
			}
			else {
				rendered = data;
			}

			$("#results").html(rendered);
			$("#resultsContainer").show();

			$("html, body").animate({ scrollTop: $("#results").offset().top }, 1000);
			CodeDaySpa.unblock();
		},

		__onParseError = function(xhr, status, error) {
			var r = $.trim(xhr.responseText);
			var parsed = $.parseJSON(r);

			Adam.unblock();

			if (parsed !== null && parsed !== undefined && "message" in parsed) {
				apMessageBox.error({
					message: parsed.message,
					width: 450,
					height: 300
				});
			}
			else {
				apMessageBox.error({
					message: "Yikes! An error didn't even come back from the server. That's bad, mmmkay?",
					height: 300,
					width: 450
				});
			}
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
		__config = $.extend({}, config);

	__init();
};
CodeDaySpa.BeautifyJsonPage.prototype = new ap.Observable();
