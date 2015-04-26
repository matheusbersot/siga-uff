function getDataToSignDocument() {
	var doc = {
		nome : "",
		url : "",
		chk : ""
	}

	var hashInf = {
		urlPost : "",
		nextUrl : "",
		urlBase : "",
		urlPath : "",
		docs : new Array()
	}

	var oUrlPost = document.getElementById("jspserver");
	hashInf.urlPost = oUrlPost.defaultValue;
	if (oUrlPost == null) {
		alert("Elemento jspserver não existe");
		return null;
	}

	var oUrlNext = document.getElementById("nexturl");
	hashInf.urlNext = oUrlNext.defaultValue;
	if (oUrlNext == null) {
		alert("Elemento nexturl não existe");
		return null;
	}

	var oUrlBase = document.getElementById("urlbase");
	hashInf.urlBase = oUrlBase.defaultValue;
	if (oUrlBase == null) {
		alert("Elemento urlbase não existe");
		return null;
	}

	var oUrlPath = document.getElementById("urlpath");
	hashInf.urlPath = oUrlPath.defaultValue;
	if (oUrlPath == null) {
		alert("Elemento urlpath não existe");
		return null;
	}

	var code;
	var nodeList = document.getElementsByTagName("INPUT");
	for (var i = 0, len = nodeList.length; i < len; i++) {

		var elem = nodeList[i];

		if (elem.name.substr(0, 7) == "pdfchk_") {

			code = elem.name.substr(7);

			var doc = {
				nome : null,
				url : null,
				chk : null
			}

			var oNome = document.getElementsByName("pdfchk_" + code)[0];
			doc.nome = oNome.defaultValue;
			if (oNome == null) {
				alert("Elemento pdfchk_" + code + " não existe");
				return null;
			}
			doc.url = (document.getElementsByName("urlchk_" + code)[0]).defaultValue;

			var oChk = document.getElementsByName("chk_" + code)[0];
			if (oChk != null) {
				doc.chk = oChk.defaultValue;
			}

			hashInf.docs.push(doc);
		}
	}

	return JSON.stringify(hashInf);
}

function getContent(url) {

	// url="https://sistemas.uff.br:443/sigaex/arquivo/exibir.action?arquivo=23069100007201526.pdf&semmarcas=1";
	var xhr = new XMLHttpRequest();
	xhr.open("GET", url, true);
	xhr.send();

	xhr.onload = function(e) {
		if (xhr.readyState === 4) {
			if (xhr.status === 200) {

				var gAtributoAssinavelDataHora = xhr.getResponseHeader("Atributo-Assinavel-Data-Hora");
				
				var blob = null;
                
                if(xhr.getResponseHeader("Content-Type") == "application/pdf") {
                    blob = new Blob([ xhr.response ], {type : 'application/pdf'});                    
                }
                
				return new Array[xhr.responseText, blob];

			} else {
				console.error(xhr.statusText);
			}
		}
	};
}
