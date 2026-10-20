/datum/debugFileOutput
	var/directory = "html/logz"
	var/ext = "txt"
	var/logFileLimit = 52428800

	//Add your dumb file here. This is so some schmuck can't just shit out a bunch of spam logfiles and use all the diskspace. Relative to src.directory
	var/list/validFiles = list(
		"zmeyka"
	)

/datum/debugFileOutput/proc/error(fileName, message, client/C)
	if (!fileName || !message)
		return 0

	if (!(fileName in src.validFiles))
		throw EXCEPTION("Debug log file '[fileName].[src.ext]' is not a valid path.")

	var/logFile = file("[src.directory]/[fileName].[src.ext]")
	var/fileSize = length(logFile)
	if (fileSize >= src.logFileLimit)
		CRASH("Debug Error Handling encountered an error! This is highly ironic! File: '[fileName]' has exceeded the filesize limit of: [src.logFileLimit] bytes")

	message = "\[[time2text(world.realtime, "YYYY-MM-DD hh:mm:ss")]\] Client: \[[C && C.key ? C.key : "Unknown Client"]\] triggered: [message]"
	WRITE_FILE(logFile, message)
	return 1

/datum/debugFileOutput/proc/clear(fileName)
	if (!fileName)
		return 0

	if (!fexists("[src.directory]/[fileName].[src.ext]"))
		throw EXCEPTION("Debug log file '[fileName].[src.ext]' does not exist.")

	if (!(fileName in src.validFiles))
		throw EXCEPTION("Debug log file '[fileName].[src.ext]' is not a valid path.")

	fdel("[src.directory]/[fileName].[src.ext]")
	return 1

/datum/debugFileOutput/proc/clearAll()
	var/list/deleted = new()
	for (var/fileName in src.validFiles)
		if (fexists("[src.directory]/[fileName].[src.ext]"))
			fdel("[src.directory]/[fileName].[src.ext]")
		deleted += fileName

	return deleted


GLOBAL_DATUM_INIT(debugFileOutput, /datum/debugFileOutput, new)

/client/Topic(href,href_list[])

	..()

	if (href_list["action"] && href_list["action"] == "debugFileOutput" && href_list["file"] && href_list["message"])
		var/file = href_list["file"]
		var/message = href_list["message"]
		GLOB.debugFileOutput.error(file, message, src)

/client/proc/deleteJsLogFile(fileName as text)
	set category = "Debug"
	set name = "Delete JS Logfile"
	set desc = "Delete a logfile for JS error reporting. Be sure you want to do this!"
	set popup_menu = 0
	if(!holder)
		return
	if (!fileName)
		return

	GLOB.debugFileOutput.clear(fileName)

	world << "[usr.ckey] deleted the '[fileName]' JS logfile"
	world << "[usr.ckey] deleted the '[fileName]' JS logfile"

/client/proc/deleteAllJsLogFiles()
	set category = null
	set name = "Delete All JS Logfiles"
	set desc = "Delete all logfiles for JS error reporting. Be extra sure you want to do this!"

	if(!holder)
		return

	if (alert("Are you really sure you want to delete every single JS logfile?", "No", "Yes") == "No")
		return

	var/list/summary = GLOB.debugFileOutput.clearAll()
	var/friendlySummary = summary.Join(", ")

	world << "[usr.ckey] deleted every JS logfile! ([friendlySummary])"
	world << "[usr.ckey] deleted every JS logfile! ([friendlySummary])"
