extends Node2D

func _ready():
	$Player/BGM.stream = load("res://Assets/Music/Dungeon Probably.mp3")
	$Player.position.x = Global.player_enter_posx
	$Player.position.y = Global.player_enter_posy
	Global.current_scene = "Dungeon1"
	$Player/CanvasLayer/GUI.visible = true
	$Teacher.type = "teacher"
	textInsider()

func textInsider():
	$Slime.index = 1
	$Slime/Label.text = "A. Keragaman Alam Indonesia
1. Bagaimana Proses Geografis Memengaruhi Keragaman 
Alam Indonesia?
Bangsa Indonesia patut bersyukur karena proses geografis dan keragaman 
alam yang dimiliki. Indonesia me rupakan negara terluas di Asia Tenggara. 
Luas da ratan Indonesia sebesar 1.910.932,37 km2
 dan lautan Indonesia 
mencapai 5,8 juta km2
. Letak Indonesia sangat menguntungkan bagi 
kehidupan masyarakat. Selain memiliki letak geografis yang sangat 
menguntungkan, Indonesia juga memiliki letak geologis, iklim, dan cuaca 
yang sangat menguntungkan.

a. Letak Geologis
Letak geologis adalah posisi suatu wilayah yang didasarkan pada 
struktur geologi atau susunan batuan di sekitarnya. Secara geologis, 
Indonesia dilalui dua jalur pegunungan dunia yaitu pegunungan Sirkum 
Pasifik dan Sirkum Mediterania. Letak tersebut menyebabkan Indonesia 
memiliki banyak gunung api aktif. Jalur pegunungan di Indonesia 
membentang dari ujung utara Sumatra memanjang melalui pantai barat 
Sumatra, melewati Pulau Jawa, Nusa Tenggara, Banda, Sulawesi, dan 
Halmahera. Jumlah gunung aktif di Indonesia sebanyak 127 gunung api.

b. Cuaca dan Iklim
Cuaca adalah kondisi rata-rata udara pada saat tertentu di suatu 
wilayah yang relatif sempit dan dalam waktu yang singkat. Iklim merupakan 
kondisi cuaca rata-rata tahunan pada suatu wilayah yang luas. Indonesia 
memiliki iklim tropis yang memiliki dua musim yaitu musim hujan 
dan musim kemarau. 

Berikut pengaruh unsur-unsur iklim terhadap 
tanaman:
a. Penyinaran matahari: Memengaruhi fotosintesis tanaman, dapat 
meningkatkan suhu udara.
b. Suhu : Mengurangi kadar air sehingga cenderung menjadi kering.
c. Kelembaban: Membatasi hilangnya air.
d. Angin: Membantu proses penyerbukan secara alami, mengurangi 
kadar air.
e. Hujan: Meningkatkan kadar air, mengikis tanah."
	
	$Slime2.index = 2
	$Slime2/Label.text = "B. Bagaimana Proses Geografis Memengaruhi Keragaman 
Sosial Budaya?

a. Keragaman Sosial Budaya di Masyarakat
 Perbedaan sosial budaya meliputi 
perbedaan nilai-nilai, norma, dan karakteristik dari suatu kelompok. 
Keragaman sosial budaya di masyarakat dapat terjadi saat berbagai jenis 
suku dan agama yang ada di suatu ruang bertemu dan berinteraksi setiap 
harinya. Ruang tersebut adalah ruang yang ada pada masyarakat. Budaya 
dapat berupa cara hidup masyarakat, cara berpakaian, adat istiadat, jenis 
mata pecaharian, dan tata upacara keagamaan.

Perbedaan budaya dapat 
disebabkan oleh berbagai hal seperti sejarah, keturunan, keyakinan, dan 
faktor geografis. Salah satu penyebab perbedaan budaya adalah faktor 
geografis.

b. Pengaruh Faktor Geografis dan Keragaman Budaya di Indonesia
Keragaman budaya dipengaruhi oleh lingkungan fisik. Manusia sebagai 
individu adalah kesatuan jiwa, raga dan kegiatan atau perilaku pribadi 
itu sendiri. Sebagai individu, dalam pribadi manusia terdapat tiga unsur, 
yaitu nafsu, semangat, dan intelegensi. Kombinasi dari unsur tersebut 
menghasilkan tingkah laku seseorang yang mencerminkan karakter atau 
budayaanya. Kesatuan dari kepribadian-kepribadian seseorang pada suatu 
daerah yang mempunyai pola yang sama dapat membentuk budaya daerah 
tersebut yang membedakan dengan tempat lain. Indonesia memiliki 
kebudayaan yang beragam.

Keragaman budaya di Indonesia dipengaruhi oleh faktor geografis 
seperti isolasi geografis, kondisi iklim, dan letak geografis."
	
	$Slime3.index = 3
	$Slime3/Label.text = "C. Sumber Daya Manusia
1. Bagaimana Kualitas Sumber Daya Manusia Indonesia?
Human Development Report (HDR) mengelompokkan negara di dunia 
menjadi empat kelompok. Keempat kelompok itu ialah kelompok negara 
berperingkat sangat tinggi (very high human development) antara 1-47, 
tinggi (high human development) antara 48-94, sedang (medium human 
development) antara 94-141, dan rendah (low human development) antara 
142-187.

Kualitas sumber daya manusia Indonesia pada saat ini dibarengi juga 
dengan adanya bonus demografi, yang dimana kondisi masyarakat berusia 
produktif lebih banyak dari pada masyarakat berusia nonproduktif. 
Kondisi ini dapat dimanfaatkan masyarakat yang berusia produktif untuk 
meningkatkan kualitasnya dalam mendapatkan finansial untuk memenuhi 
kebutuhan dalam hidupnya. Pengelolaan finansial yang dilakukan dengan 
baik oleh masyarakat produktif bermanfaat untuk mengelola sumber daya 
keuangan secara efektif untuk kesejahteraan hidup, serta pemanfaatan 
sumber daya sebagai amunisi untuk pembentukan dan penguatan 
kualitas sumber daya manusia Indonesia yang kompeten, kompetitif, dan 
berintegritas dalam menghadapi persaingan di era globalisasi dan pasar 
bebas. Kualitas sumber daya manusia dapat ditentukan dengan pendidikan, 
agama, peningkatan kapasitas SDM, dan pengembangan masyarakat 
generasi muda."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	Global.pause_menu($Player/CanvasLayer/PauseMenu)

func _on_dungeon_2_transfer_body_entered(body):
	if body.has_method("player"):
		Global.current_scene = "Dungeon2"
		Global.transition = true
		Global.player_enter_posx = 319
		Global.player_enter_posy = 303

func _on_dungeon_2_transfer_body_exited(body):
	if body.has_method("player"):
		Global.transition = false

func change_scene():
	if Global.transition:
		if Global.current_scene == "Dungeon2":
			get_tree().change_scene_to_file("res://Scene/Dungeon2.tscn")
