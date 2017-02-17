require 'squib'

PROOF = false
HATCHET_REQUIRED= %w(wood fibre flint)

#tiles
def generate_tile_fronts count, data, flavour

  Squib::Deck.new(cards: count, layout: 'tile-front.yml', width: 450, height: 450) do
    puts flavour
    data = csv file: "data/#{flavour}.csv"
    png file: "art/#{flavour}.png", layout: 'background'


    found = data['found'].zip(data['qf']).map {|r| "#{r[0]}#{r[1]}" }
    png file: as_art(found), layout: 'found-resource'
    png file: flip(data['found'], data['qf']), layout: 'found-resource'

    gather1 = data['gather1'].zip(data['q1']).map {|r| "#{r[0]}#{r[1]}" }
    png file: as_art(gather1), layout: 'gather1'
    png file: hatchet(data['gather1'], data['q1']), layout: 'gather1'

    gather2 = data['gather2'].zip(data['q2']).map {|r| "#{r[0]}#{r[1]}" }
    png file: as_art(gather2), layout: 'gather2'
    png file: hatchet(data['gather2'], data['q2']), layout: 'gather2'

    mystery = data['mystery'].zip(data['qm']).map {|r| "#{r[0]}#{r[1]}" }
    png file: as_art(mystery), layout: 'mystery'

    if PROOF
      png file: "art/proof-hextile.png", layout: 'background'
    end
    # text str: data['Title'], layout: 'title'
    # save prefix: "#{flavour}[face]", format: :png
    save_sheet  prefix: "sheet_#{flavour}[face]", columns: 5, rows: 5
    # save_pdf file: 'relics.pdf', width: cm(29.7), height: cm(21), margin: cm(0.5), gap: 29
  end
end

def as_art (names)
  names.map {|a| "art/#{a}.png"}
end

def flip(array_of_things, array_of_counts)
  flip = array_of_things.zip(array_of_counts).map! {|r| r[0]=="none" ? "none" : "flip#{r[1]}" }
  as_art(flip)
end

def hatchet(array_of_things, array_of_counts)
  hatchet = array_of_things.map do |a| 
    (HATCHET_REQUIRED.include? a) ? "microhatchet" : "none"
  end
  hatchet = hatchet.zip(array_of_counts).map! {|r| r[0]=="none" ? "none" : "#{r[0]}#{r[1]}" }
  as_art(hatchet)
end


def generate_tile_backs count, flavour
  Squib::Deck.new(cards: count, layout: 'tile-front.yml', width: 450, height: 450) do
    png file: "art/#{flavour}.png", layout: 'background'
    save_sheet  prefix: "sheet_#{flavour}[back]", columns: 5, rows: 5
  end
end

def generate_tiles count, data, flavour
  generate_tile_fronts count, data, flavour
  generate_tile_backs count, flavour
end

generate_tiles 22, nil, "jungle"
generate_tile_fronts 21, nil, "sand"
generate_tile_fronts 21, nil, "shallow"
generate_tiles 5, nil, "deep"
generate_tiles 10, nil, "cliff"
generate_tiles 5, nil, "summit"



#focuses
# Squib::Deck.new(cards: 30, layout: 'rite-layout.yml', width: 825, height: 1125) do
# 	data = csv file: 'focus.csv'
#   background color: 'white'
# 	border_filename = data['Colour2'].map do |a| 
#   	a == 'none' ? 'art/cult_following_ends_one_icon.png' : 'art/cult_following_ends_two_icons.png'
#   end
#   png file: data['Image'].map {|a| "art/#{a}.png" }, layout: 'image'
#   png file: border_filename
#   text str: data['Name'], layout: 'name_focus'
#   png file: data['Colour1'].map {|a| "art/icon_#{a}.png" }, layout: 'icon1'
#   png file: data['Colour2'].map {|a| "art/icon_#{a}.png" }, layout: 'icon2'
#   # save prefix: 'focus', format: :png
# 	save_sheet  prefix: 'group_focus_', columns: 4, rows: 2
#   save_pdf file: 'focuses.pdf', width: cm(29.7), height: cm(21), margin: cm(0.5), gap: 29
 
# end

#rites
# Squib::Deck.new(cards: 30, layout: 'rite-layout.yml', width: 825, height: 1125) do
# 	data = csv file: 'rite.csv'
#   background color: 'white'
# 	border_filename = data['Colour2'].map do |a| 
#   	a == 'none' ? 'art/cult_following_starts_one_icon.png' : 'art/cult_following_starts_two_icons.png'
#   end
#   png file: data['Image'].map {|a| "art/#{a}.png" }, layout: 'image'
#   png file: border_filename
#   text str: data['Name'], layout: 'name_rite'
#   png file: data['Colour1'].map {|a| "art/icon_#{a}.png" }, layout: 'icon1'
#   png file: data['Colour2'].map {|a| "art/icon_#{a}.png" }, layout: 'icon2'
#   # save prefix: 'rite', format: :png
# 	save_sheet  prefix: 'group_rite_', columns: 4, rows: 2
#   save_pdf file: 'rites.pdf', width: cm(29.7), height: cm(21), margin: cm(0.5), gap: 29
# end

#people
# Squib::Deck.new(cards: 29, layout: 'people-layout.yml', width: 825, height: 1125) do
# 	data = csv file: 'people.csv'
#   background color: 'white'
#   png file: 'art/people_back.png'
#   png file: data['Image'].map {|a| "art/#{a}.png" }, layout: 'image'
#   png file: data['Passion1'].map {|a| "art/icon_#{a}.png" }, layout: 'passion1'
#   png file: data['Passion2'].map {|a| "art/icon_#{a}.png" }, layout: 'passion2'
#   png file: data['Passion3'].map {|a| "art/icon_#{a}.png" }, layout: 'passion3'
#   png file: data['Passion4'].map {|a| "art/icon_#{a}.png" }, layout: 'passion4'
#   png file: data['Fear1'].map {|a| "art/icon_#{a}.png" }, layout: 'fear1'
#   png file: data['Fear2'].map {|a| "art/icon_#{a}.png" }, layout: 'fear2'
#   png file: data['Fear3'].map {|a| "art/icon_#{a}.png" }, layout: 'fear3'
#   png file: data['Fear4'].map {|a| "art/icon_#{a}.png" }, layout: 'fear4'
#   text str: data['Score'], layout: 'score'
#   text str: data['Name'], layout: 'name'
#   # save prefix: 'person', format: :png
#   save_sheet  prefix: 'group_followers_', columns: 4, rows: 2
#   save_pdf file: 'followers.pdf', width: cm(29.7), height: cm(21), margin: cm(0.5), gap: 29
# end

#philosophies
# Squib::Deck.new(cards: 16, layout: 'philosophy-layout.yml', width: 825, height: 1125) do
#   data = csv file: 'philosophy.csv'

#   background color: 'white'
#   text str: data['Title'], layout: 'title'
#   text str: data['Requirement'], layout: 'requirement'
#   text str: data['Score'], layout: 'score'
#   save_sheet  prefix: 'group_philosophy_', columns: 4, rows: 2
#   save_pdf file: 'philosophies.pdf', width: cm(29.7), height: cm(21), margin: cm(0.5), gap: 29
# end

#backs
# Squib::Deck.new(cards: 8, layout: 'card-back.yml', width: 825, height: 1125) do
#   png file: 'art/cult_following_backs.png'
#   png file: 'art/cardback-follower.png', layout: 'image'
#   save_sheet  prefix: 'back_follower', columns: 4, rows: 2
#   save_pdf file: 'followers_back.pdf', width: cm(29.7), height: cm(21), margin: cm(0.5), gap: 29
# end

# Squib::Deck.new(cards: 8, layout: 'card-back.yml', width: 825, height: 1125) do
#   png file: 'art/cult_following_backs.png'
#   png file: 'art/cardback-ritual.png', layout: 'image'
#   save_sheet  prefix: 'back_ritual', columns: 4, rows: 2
#   save_pdf file: 'ritual_back.pdf', width: cm(29.7), height: cm(21), margin: cm(0.5), gap: 29
# end

# Squib::Deck.new(cards: 8, layout: 'card-back.yml', width: 825, height: 1125) do
#   png file: 'art/cult_following_backs.png'
#   png file: 'art/cardback-philosophy.png', layout: 'image'
#   save_sheet  prefix: 'back_philosophy', columns: 4, rows: 2
#   save_pdf file: 'philosophy_back.pdf', width: cm(29.7), height: cm(21), margin: cm(0.5), gap: 29
# end