extends Node

var data_path
var default_data = ""
var data_file = File.new()

func set_path(path):
	data_path = path
	
func set_dd(data):
	default_data = data
	

func load_data():
	# Create data file object
	# Create dictionary to return
	var data = {}
	
	if not data_file.file_exists(data_path):
		data_file.open(data_path, File.WRITE)
		data_file.store_line(default_data)
		data_file.close()
		
	data_file.open(data_path, File.READ)
	var raw_data = data_file.get_line().replace("\"", "")
	if raw_data == "": 
		raw_data = default_data
	raw_data = raw_data.replace("}","")
	raw_data = raw_data.replace("{","")
	data_file.close()
	
	# split
	var raw_data_commasplit = raw_data.split(",")
	
	#add to dict
	for elem in raw_data_commasplit:
		var raw_data_commasplit_elems = elem.split(":")
		data[raw_data_commasplit_elems[0]] = raw_data_commasplit_elems[1]
	print(data)
	return data

func save_data(data):
	data_file.open(data_path, File.WRITE)
	var to_save = JSON.print(data)
	print(to_save)
	data_file.store_string(to_save)
	data_file.close()
	
func file_exists_wrapper(path):
	return data_file.file_exists(path)