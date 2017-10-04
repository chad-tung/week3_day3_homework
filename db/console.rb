require("pry")
require_relative("../models/artists")
require_relative("../models/albums")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new( {'name'=>"Coldplay"} )
artist1.save()

artist2 = Artist.new( {'name'=>"The Beatles"})
artist2.save()

artist3 = Artist.new( {'name'=>"Pink Floyd"})
artist3.save()

album1 = Album.new( {'title'=>'Ghost Stories', 'genre'=>'alternative rock', 'artist_id'=>artist1.id()})
album1.save()

album2 = Album.new( {'title'=>'A Head Full of Dreams', 'genre'=>'alternative rock', 'artist_id'=>artist1.id()})
album2.save()

album3 = Album.new( {'title'=>'Rubber Soul', 'genre'=>'pop/rock', 'artist_id'=>artist2.id()})
album3.save()

album4 = Album.new( {'title'=>'Revolver', 'genre'=>'pop/rock', 'artist_id'=>artist2.id()})
album4.save()

album5 = Album.new( {'title'=>'The Dark Side of the Moon', 'genre'=>'progressive rock', 'artist_id'=>artist3.id()})
album5.save()

album6 = Album.new( {'title'=>'Wish You Were Here', 'genre'=>'progressive rock', 'artist_id'=>artist3.id()})
album6.save()



binding.pry
nil
