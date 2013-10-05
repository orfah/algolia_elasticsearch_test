mongoose = require 'mongoose'
fibrous = require 'fibrous'
mongoose.connect('mongodb://localhost/garbanzo_development')

vendorPrefixes = [
  'good', 'full', 'organic', 'fresh',
  'happy', 'smiling', 'red', 'natural', 
  'natural', 'blue', 'green', 'fair',
  'blank', 'fairy', 'wishing', 'pure',
  'gracious', 'enchanting', 'fabulous', 'delicious',
  'tasty', 'yum', 'yummy', 'scrumptious',
  'classy', 'elegant', 'delish', 'faboo'
]

vendorNouns = [
  'farms', 'ranch', 'bakery', 'pastashop',
  'cookery', 'breads', 'homes', 'gardens',
  'tea', 'foods', 'coffees', 'grove',
  'co-op', 'chocolates', 'shop', 'foods',
  'collective', 'kitchen', 'house', 'cafe'
]

productPrefixes = [
  'red', 'blue', 'green', 'yellow',
  'dry', 'organic', 'snow', 'prickly',
  'baby', 'fresh', 'flamingo', 'baby doll',
  'winter', 'summer', 'fall', 'spring', 
  'candy', 'bitter', 'sweet', 'sour',
  'german', 'mexican', 'southern', 'northern',
  'eastern', 'western', 'asian', 'european',
  'siberian', 'australian', 'egyptian', 'kenyan',
  'nairobian', 'canadian', 'chinese', 'japanese'
]

productNouns = [
  'tomatoes', 'cucumbers', 'potatoes', 'radishes',
  'squash', 'melons', 'bread', 'pasta',
  'cakes', 'candies', 'oils', 'chard',
  'kale', 'garbanzos', 'beans', 'peas',
  'butternut squash', 'apples', 'bananas', 'oranges',
  'lemons', 'limes', 'sage', 'basil',
  'corriander', 'cilantro', 'turtle', 'spices',
  'flowers', 'tamales', 'chips', 'salsa'
]

tags = [
    "Gluten-free Baby Food"
  , "Non-dairy Alternatives"
  , "Salami & Cured Meats"
  , "Cultures"
  , "Pet Food"
  , "Ice Cream"
  , "Milk & Cream"
  , "Butter"
  , "Vegan & Vegetarian Baby Food"
  , "Poultry"
  , "Home Goods"
  , "Fresh Juice"
  , "Solid Foods"
  , "Beef & Lamb"
  , "Sea Vegetables"
  , "Flowers"
  , "Flour, Grains, Beans & Pasta"
  , "Wares"
  , "Bagels, Biscuits & Scones"
  , "Gift Box"
  , "Gift Certificate"
  , "Coffee & Tea"
  , "Crackers, Chips, Dips & Spreads"
  , "Fresh Herbs"
  , "Greens"
  , "Cheese"
  , "Fish & Shellfish"
  , "Ethnic Food"
  , "Event"
  , "Drinks"
  , "Herbs & Spices"
  , "Cakes & Pies"
  , "Eggs"
  , "Fruits"
  , "Meal Boxes"
  , "Cookies & Pastries"
  , "Kids Meals"
  , "Pickles & Preserves"
  , "Muffins & Cupcakes"
  , "Pork & Rabbit"
  , "Ready Meals"
  , "Bath & Body"
  , "Gluten-free Staples"
  , "Sausages & Bacon"
  , "Cereals & Granola"
  , "Ice Cream & Frozen Treats"
  , "Gluten-free Bread & Sweets"
  , "Vegan & Vegetarian Meals"
  , "Snacks"
  , "Vegetables"
  , "Eggs, Dairy & Cheese"
  , "Gardening Goodies"
  , "Pureed Foods"
  , "Market Basket/Recipe Kit"
  , "Oils, Vinegars & Condiments"
  , "Nuts, Nut Butters, Honey & Dried Fruit"
  , "Stock, Broth & Sauce"
  , "Class"
  , "Meat"
  , "Chocolates & Sweets"
  , "Bread"
  , "Gluten-free Meals"
]

randCeil = (l) ->
  randFloor(l)

randFloor = (l) ->
  Math.ceil(Math.random() * (l-1))
   
generateName = (prefixes, nouns) ->
  prefixBits = []
  numPrefixes = randFloor 10
  nounIndex = randFloor nouns.length

  for i in [0...numPrefixes]
    prefixBits.push prefixes[randFloor prefixes.length]

  prefixBits = unique prefixBits
  (prefixBits.join(' ') + ' ' + nouns[nounIndex]).trim()

generateVendorName = ->
  generateName(vendorPrefixes, vendorNouns)

generateProducts = ->
  products = []
  numProducts = randCeil 150
  for i in [0...numProducts]
    products.push generateProduct()
  products

generateTags = ->
  numTags = randFloor 10
  tagBits = []
  for i in [0...numTags]
    tagBits.push tags[Math.floor(Math.random() * (tags.length - 1))]

  unique tagBits

generateProduct = ->
  name: generateName(productPrefixes, productNouns)
  tags: generateTags()

unique = (array) ->
  hash = {}
  hash[elt] = elt for elt in array
  elt for key, elt of hash

documents = []
for i in [0...10000]
  document = 
    vendor: generateVendorName()
    products: generateProducts()
  documents.push document

console.log JSON.stringify documents
