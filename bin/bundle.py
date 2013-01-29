import os, re, shutil

COMPRESSOR = "yuicompressor-2.4.7.jar"


def compress(inFiles, outFile, type = "js", verbose = False, tempFile = ".temp"):
	temp = open(tempFile, "w")

	for f in inFiles:
		fp = open(f, "r")
		data = fp.read() + "\n"
		fp.close()

		temp.write(data)
		print " + %s" % f

	temp.close()

	options = ['-o "%s"' % outFile, '--type %s' % type]

	if verbose:
		options.append("-v")

	os.system('java -jar "%s" %s "%s"' % (COMPRESSOR, " ".join(options), tempFile))
	os.remove(tempFile)

def getCssFileList(templateFile):
	fp = open(templateFile, "r")
	raw = fp.read()
	fp.close()

	pattern = re.compile(r"<!---CSS-START--->(.*?)<!---CSS-END--->", re.I | re.S)
	matches = pattern.findall(raw)

	if matches:
		pattern = re.compile(r"<link\srel=\"stylesheet\"\stype=\"text/css\"\shref=\"(.*?)\"\s/>", re.I | re.S)
		matches = ["..%s" % pattern.sub("\\1", i.strip()) for i in matches[0].strip().split("\n")]

	return matches

def getJsFileList(templateFile):
	fp = open(templateFile, "r")
	raw = fp.read()
	fp.close()

	pattern = re.compile(r"<!---JS-START--->(.*?)<!---JS-END--->", re.I | re.S)
	matches = pattern.findall(raw)

	if matches:
		pattern = re.compile(r"<script\ssrc=\"(.*?)\"></script>", re.I | re.S)
		matches = ["..%s" % pattern.sub("\\1", i.strip()) for i in matches[0].strip().split("\n")]

	return matches

def updateLayoutFile(templateFile):
	fp = open(templateFile, "r")
	raw = fp.read()
	fp.close()

	pattern = re.compile(r"<!---CSS-START--->(.*?)<!---CSS-END--->", re.I | re.S)
	raw = pattern.sub('<link rel="stylesheet" type="text/css" href="/resources/css/all.css" />', raw)

	pattern = re.compile(r"<!---JS-START--->(.*?)<!---JS-END--->", re.I | re.S)
	raw = pattern.sub('<script src="/resources/js/all.js"></script>', raw)

	fp = open(templateFile, "w")
	fp.write(raw)
	fp.close()


if __name__ == "__main__":
	layoutFiles = ("../layouts/default.cfm",)

	for layoutFile in layoutFiles:
		print "Bundling and minifying CSS..."
		compress(getCssFileList(layoutFile), "../resources/css/all.css", type = "css")

		print ""

		print "Bundling and minifying JS..."
		compress(getJsFileList(layoutFile), "../resources/js/all.js", type = "js")

		updateLayoutFile(layoutFile)
		