extends Node

#WebGL is annoying, and I'm being lazy, so I'll just do it this way for now
const g1 = []
const g2 = []
const g3 = ["", "", "", "",
"rode,rideの過去形,,3,4,4,55
biycle,自転車,,3,4,4,55
toward,…に向かって,,3,4,4,55
apartment,アパート,,3,4,4,55
caught,catchの過去形,,3,4,4,55
tsunami,津波,,3,4,4,55
sudden,突然の,,3,4,4,55
news,知らせ,,3,4,4,55
shortly,まもなく,,3,4,4,55
corner,コーナー,,3,4,4,55
exchange,交流,,3,4,4,55
program,プログラム,,3,4,4,55
support,…を支える、支援する,,3,4,4,55
ordinary,ふつうの、通常,,3,4,4,55
crisis,危機,,3,4,4,55
several,いくつかの,,3,4,3,54
bridge,かけ橋,,3,4,3,54
between,…の間,,3,4,3,54
energetic,エネルギッシュな,,3,4,3,54
encourage,…を励ます,,3,4,3,54
personality,性格,,3,4,3,54
hit,襲う,,3,4,3,54
comfort,…を元気づける,,3,4,3,54
nearby,近くの,,3,4,3,54
safe,安全な,,3,4,3,54
ALT,外国語指導補助教員,,3,4,3,54
all the time,常に,,3,4,3,54
done,doの過去分詞,,3,4,2,53
prepare,（…の）準備をする、備える,,3,4,2,53
emergency,緊急事態,,3,4,2,53
kit,道具［用具］一式,,3,4,2,53
recommend,…をすすめる,,3,4,2,53
earthquake,地震,,3,4,2,53
we've,<= we have,,3,4,2,53
hasn't,<= has not,,3,4,2,53
prepared,用意ができている、備えた,,3,4,1,52
disaster,災害,,3,4,1,52
shelter,避難所,,3,4,1,52
store,…を蓄える,,3,4,1,52
case,場合,,3,4,1,52
extinguisher,消火器,,3,4,1,52
in case of,…の場合には,,3,4,1,52"
]

func get_list(grade : int = 3, unit: int = 4, list_num: int = 4) -> Array[Vocab]:
	var list_text : Array = []
	var unit_text : Array
	var return_list : Array[Vocab]
	
	match grade:
		1:
			list_text.assign(g1)
		2:
			list_text.assign(g2)
		3:
			list_text.assign(g3)
		_:
			pass 
	unit_text = list_text[unit].split("\n")
	
	#take each array in unit_text and make into a Vocab
	for vocabulary in unit_text:
		var vocab_arr = vocabulary.split(",")
		var new_vocab : Vocab 
		if int(vocab_arr[5]) == list_num:
			new_vocab = Vocab.new(vocab_arr)
			return_list.push_back(new_vocab)
	return return_list
