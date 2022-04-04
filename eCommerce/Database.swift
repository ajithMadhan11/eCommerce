//
//  Database.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 17/03/22.
//

import Foundation
import UIKit

final class Database {
    
    static let context = UserData.context
    
    static func preloadItems(){
        
        let cat = Category(context: context)
        cat.name = Categories.FoodGrains.rawValue
        cat.color = UIColor(red: 0.57, green: 0.94, blue: 0.29, alpha: 0.2)
        cat.image = "rice"

        let cat7 = Category(context: context)
        cat7.name = Categories.Oils.rawValue
        cat7.color = UIColor(red: 0.57, green: 0.94, blue: 0.29, alpha: 0.2)
        cat7.image = "oil"

        let cat1 = Category(context: context)
        cat1.name = Categories.Vegetables.rawValue
        cat1.color = UIColor(red: 0.32, green: 0.69, blue: 0.45, alpha: 0.2)
        cat1.image = "vegetables"

        let cat2 = Category(context: context)
        cat2.name = Categories.Fruits.rawValue
        cat2.color = UIColor(red: 0.97, green: 0.64, blue: 0.29, alpha: 0.2)
        cat2.image = "fruits"

        let cat3 = Category(context: context)
        cat3.name = Categories.Bakery.rawValue
        cat3.color = UIColor(red: 0.96, green: 0.64, blue: 0.57, alpha: 0.2)
        cat3.image = "cake"

        let cat5 = Category(context: context)
        cat5.name = Categories.Fish.rawValue
        cat5.color = UIColor(red: 0.99, green: 0.89, blue: 0.59, alpha: 0.2)
        cat5.image = "fish"

        let cat6 = Category(context: context)
        cat6.name = Categories.Meat.rawValue
        cat6.color = UIColor(red: 0.71, green: 0.87, blue: 0.96, alpha: 0.2)
        cat6.image = "meat"
       
        let comment = Comments(context: context)
        comment.star = 2
        comment.title = "This is an clean and hygenic Lorem ipsum dolor sit amet, consectetur adipiscing"
        comment.date = Date() - 6
        comment.name = "Harsha"
        comment.comment = "This is an clean and hygenic Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris malesuada orci tempus egestas cursus. Duis molestie suscipit lacinia. Phasellus enim turpis, volutpat quis maximus nec, dignissim nec dui. Suspendisse nisl justo, sodales eget eleifend non, vehicula non elit. Nulla at egestas ex. Nullam vehicula urna dolor,"
        
        let comment1 = Comments(context: context)
        comment1.star = 3
        comment1.title = "Clean,Cool Fresh and hygenic"
        comment1.date = Date() - 5
        comment1.name = "Pranesh"
        comment1.comment = "This is an clean and hygenic Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris malesuada orci tempus egestas cursus. Duis molestie suscipit lacinia. Phasellus enim turpis, volutpat quis maximus nec, dignissim nec dui. Suspendisse nisl justo, sodales eget eleifend non, vehicula non elit. Nulla at egestas ex. Nullam vehicula urna dolor,"
        
        let comment2 = Comments(context: context)
        comment2.star = 5
        comment2.title = "Clean,Cool Fresh and hygenic"
        comment2.date = Date() - 2
        comment2.name = "Libin"
        comment2.comment = "This is an clean and hygenic Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris malesuada orci tempus egestas cursus. Duis molestie suscipit lacinia. Phasellus enim turpis, volutpat quis maximus nec, dignissim nec dui. Suspendisse nisl justo, sodales eget eleifend non, vehicula non elit. Nulla at egestas ex. Nullam vehicula urna dolor,"
        
        let comment3 = Comments(context: context)
        comment3.star = 4
        comment3.title = "Clean,Cool Fresh and hygenic"
        comment3.date = Date() - 7
        comment3.name = "Rahul"
        comment3.comment = "This is an clean and hygenic Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris malesuada orci tempus egestas cursus. Duis molestie suscipit lacinia. Phasellus enim turpis, volutpat quis maximus nec, dignissim nec dui. Suspendisse nisl justo, sodales eget eleifend non, vehicula non elit. Nulla at egestas ex. Nullam vehicula urna dolor,"
        
        let comment4 = Comments(context: context)
        comment4.star = 1
        comment4.title = "This is an clean and hygenic Lorem ipsum dolor sit amet, consectetur adipiscing"
        comment4.date = Date() - 1
        comment4.name = "kanna"
        comment4.comment = "This is an clean and hygenic Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris malesuada orci tempus egestas cursus. Duis molestie suscipit lacinia. Phasellus enim turpis, volutpat quis maximus nec, dignissim nec dui. Suspendisse nisl justo, sodales eget eleifend non, vehicula non elit. Nulla at egestas ex. Nullam vehicula urna dolor,"
        
        let comment5 = Comments(context: context)
        comment5.star = 4
        comment5.title = "Clean,Cool Fresh and hygenic"
        comment5.date = Date() - 9
        comment5.name = "Aravinth"
        comment5.comment = "This is an clean and hygenic Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris malesuada orci tempus egestas cursus. Duis molestie suscipit lacinia. Phasellus enim turpis, volutpat quis maximus nec, dignissim nec dui. Suspendisse nisl justo, sodales eget eleifend non, vehicula non elit. Nulla at egestas ex. Nullam vehicula urna dolor,"
        
        let comment6 = Comments(context: context)
        comment6.star = 3
        comment6.title = "This is an clean and hygenic Lorem ipsum dolor sit amet, consectetur adipiscing"
        comment6.date = Date() - 6
        comment6.name = "Ajithadhan"
        comment6.comment = "This is an clean and hygenic Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris malesuada orci tempus egestas cursus. Duis molestie suscipit lacinia. Phasellus enim turpis, volutpat quis maximus nec, dignissim nec dui. Suspendisse nisl justo, sodales eget eleifend non, vehicula non elit. Nulla at egestas ex. Nullam vehicula urna dolor,"
        
        let comment7 = Comments(context: context)
        comment7.star = 2
        comment7.title = "This is an clean and hygenic Lorem ipsum dolor sit amet, consectetur adipiscing"
        comment7.date = Date()
        comment7.name = "Madhan"
        comment7.comment = "This is an clean and hygenic Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris malesuada orci tempus egestas cursus. Duis molestie suscipit lacinia. Phasellus enim turpis, volutpat quis maximus nec, dignissim nec dui. Suspendisse nisl justo, sodales eget eleifend non, vehicula non elit. Nulla at egestas ex. Nullam vehicula urna dolor,"
        
        
        let product = Product(context: context)
        product.title = "Apple"
        product.productDetails = "An apple is a sweet, edible fruit produced by an apple tree (Malus domestica). Apple trees are cultivated worldwide and are the most widely grown species in the genus Malus."
        product.images = "apple-1"
        product.price = 4.99
        product.offer = 20
        product.oneStar = 21
        product.twoStar = 43
        product.threeStar = 25
        product.fourStar = 81
        product.fiveStar = 27
        product.category = Categories.Fruits.rawValue
        product.nutritions = "One medium-sized apple (200g) provides 104 calories, 0.5g of protein, 27.6g of carbohydrates, and 0.3g of fat. Apples also provide fiber, potassium, and vitamin C."
        product.review = 4.3
        product.addToReviews(comment1)
        product.addToReviews(comment2)
        product.addToReviews(comment3)
        product.addToReviews(comment4)
        
        
        let product2 = Product(context: context)
        product2.title = "Orange"
        product2.productDetails = "The orange is the fruit of the citrus species Citrus × sinensis in the family Rutaceae , native to China. It is also called sweet orange, to distinguish it from the related Citrus × aurantium, referred to as bitter orange."
        product2.images = "orange-1"
        product2.price = 4.99
        product2.offer = 30
        product2.oneStar = 42
        product2.twoStar = 23
        product2.threeStar = 45
        product2.fourStar = 90
        product2.fiveStar = 66
        product2.category = Categories.Fruits.rawValue
        product2.nutritions = "Oranges are low in calories but contain a good amount of fiber and vitamin C as well as a range of other important vitamins, minerals and antioxidants."
        product2.review = 4.5
        product2.addToReviews(comment1)
        product2.addToReviews(comment2)
        product2.addToReviews(comment3)
        product2.addToReviews(comment4)

        let product3 = Product(context: context)
        product3.title = "Dragon Fruit"
        product3.productDetails = "Dragon fruit is the fruit of a kind of cactus that grows in dry areas of South America. Usually the skin of the dragon fruit is red and the pulp is red or white. Dragon fruit is sometimes used as medicine. The fruit is also popular as a food."
        product3.images = "dragonFruit"
        product3.price = 8.99
        product3.offer = 87
        product3.oneStar = 25
        product3.twoStar = 75
        product3.threeStar = 62
        product3.fourStar = 55
        product3.fiveStar = 44
        product3.category = Categories.Fruits.rawValue
        product3.nutritions = "Dragon fruit is high in fiber and antioxidant properties, including certain minerals and vitamins that are beneficial for our health. In this section, we have outlined the nutritional value of the dragon fruit with the help of tables to help you get a clear insight into its health benefits. "
        product3.review = 4.8
        product3.addToReviews(comment6)
        product3.addToReviews(comment7)
        product3.addToReviews(comment5)
        product3.addToReviews(comment4)
        
        
        let product4 = Product(context: context)
        product4.title = "Kiwi"
        product4.productDetails = "Kiwi berries are edible fruits the size of a large grape, similar to fuzzy kiwifruit in taste and internal appearance, but the thin, smooth green skin and lack of fuzz makes eating the entire fruit more pleasant."
        product4.images = "kiwi"
        product4.price = 5.99
        product4.offer = 27
        product4.oneStar = 66
        product4.twoStar = 36
        product4.threeStar = 88
        product4.fourStar = 96
        product4.fiveStar = 54
        product4.category = Categories.Fruits.rawValue
        product4.nutritions = "Kiwis are a good source of vitamin C, antioxidants, and fiber.Antioxidants — including vitamin C, choline, lutein, and zeaxanthin — help remove free radicals from the body. Free radicals are unstable molecules that the body produces during metabolism and other processes."
        product4.review = 3.5
        product4.addToReviews(comment6)
        product4.addToReviews(comment7)
        product4.addToReviews(comment5)
        product4.addToReviews(comment4)
        
        let product5 = Product(context: context)
        product5.title = "Pomegranate"
        product5.productDetails = "A pomegranate is a sweet, tart fruit with thick, red skin.Pomegranates are grown on trees. These trees need ample heat to grow and ripen these hard, delicious fruits."
        product5.images = "pomo"
        product5.price = 6.99
        product5.offer = 52
        product5.oneStar = 97
        product5.twoStar = 35
        product5.threeStar = 21
        product5.fourStar = 64
        product5.fiveStar = 72
        product5.category = Categories.Fruits.rawValue
        product5.nutritions = "Pomegranates can have up to three times more antioxidants than green tea or red wine. Antioxidants protect cells from damage, prevent diseases such as cancer and reduce inflammation and the effects of aging."
        product5.review = 4.5
        product5.addToReviews(comment6)
        product5.addToReviews(comment7)
        product5.addToReviews(comment5)
        product5.addToReviews(comment4)
        
        
        let product6 = Product(context: context)
        product6.title = "Pineapple"
        product6.productDetails = "Pineapple is a large tropical fruit with a spiky, tough skin and sweet insides. When European explorers came across it in South America in the 17th century, they called it a pineapple because of its pinecone appearance."
        product6.images = "pineApple"
        product6.price = 8.99
        product6.offer = 52
        product6.oneStar = 96
        product6.twoStar = 19
        product6.threeStar = 26
        product6.fourStar = 74
        product6.fiveStar = 69
        product6.category = Categories.Fruits.rawValue
        product6.nutritions = "The vitamins and minerals in pineapple could help shorten viral and bacterial infections and strengthen your bones. There's also a little evidence that pineapple may help prevent cancer."
        product6.review = 3.8
        product6.addToReviews(comment1)
        product6.addToReviews(comment2)
        product6.addToReviews(comment3)
        product6.addToReviews(comment4)
        
        
        let product7 = Product(context: context)
        product7.title = "Guava"
        product7.productDetails = "Guava is a common fruit. There are two varieties of Guava fruit; which have red and white pulp. According to the taste, this fruit is sour, sweet and insipid."
        product7.images = "guava"
        product7.price = 4.99
        product7.offer = 29
        product7.oneStar = 64
        product7.twoStar = 95
        product7.threeStar = 33
        product7.fourStar = 52
        product7.fiveStar = 45
        product7.category = Categories.Fruits.rawValue
        product7.nutritions = "Guava fruit in rich in nutritious elements; ts is recognized as one of the highly nutritious fruit. It is enriched with nutritious molecules, like protein,dietary fibers,sugars,lycopene etc."
        product7.review = 4.8
        product7.addToReviews(comment1)
        product7.addToReviews(comment2)
        product7.addToReviews(comment3)
        product7.addToReviews(comment4)
        
        let product8 = Product(context: context)
        product8.title = "Banana"
        product8.productDetails = "A banana is an elongated, edible fruit – botanically a berry – produced by several kinds of large herbaceous flowering plants in the genus Musa.The fruit is variable in size, color, and firmness, but is usually elongated and curved, with soft flesh rich in starch."
        product8.images = "banana-1"
        product8.price = 3.99
        product8.offer = 35
        product8.oneStar = 58
        product8.twoStar = 75
        product8.threeStar = 69
        product8.fourStar = 85
        product8.fiveStar = 63
        product8.category = Categories.Fruits.rawValue
        product8.nutritions = "Bananas are a good source of several vitamins and minerals, especially potassium, vitamin B6, and vitamin C"
        product8.review = 4.8
        product8.addToReviews(comment1)
        product8.addToReviews(comment2)
        product8.addToReviews(comment3)
        product8.addToReviews(comment4)
        
        
        let product9 = Product(context: context)
        product9.title = "Strawberry"
        product9.productDetails = "The strawberry is a beautifully sweet, aromatic, fiber-rich fruit packed with vitamins, minerals, and antioxidants. Strawberries are one of the most well-liked fruits on the market, with a naturally delicious flavor and lots of health benefits to offer."
        product9.images = "strawberry"
        product9.price = 8.99
        product9.offer = 15
        product9.oneStar = 69
        product9.twoStar = 22
        product9.threeStar = 71
        product9.fourStar = 72
        product9.fiveStar = 96
        product9.category = Categories.Fruits.rawValue
        product9.nutritions = "Strawberries are an excellent source of vitamin C, fiber, and potassium.Strawberries are naturally very low in fat—half a gram per cup. The majority of these are polyunsaturated fatty acids."
        product9.review = 2.8
        product9.addToReviews(comment1)
        product9.addToReviews(comment2)
        product9.addToReviews(comment3)
        product9.addToReviews(comment4)
        
        
        let product91 = Product(context: context)
        product91.title = "Jackfruit"
        product91.productDetails = "The Jackfruit is a beautifully sweet, aromatic, fiber-rich fruit packed with vitamins, minerals, and antioxidants. Strawberries are one of the most well-liked fruits on the market, with a naturally delicious flavor and lots of health benefits to offer."
        product91.images = "jackFruit"
        product91.price = 8.99
        product91.offer = 15
        product91.oneStar = 69
        product91.twoStar = 22
        product91.threeStar = 71
        product91.fourStar = 72
        product91.fiveStar = 96
        product91.category = Categories.Fruits.rawValue
        product91.nutritions = "Jackfruit are an excellent source of vitamin C, fiber, and potassium.Strawberries are naturally very low in fat—half a gram per cup. The majority of these are polyunsaturated fatty acids."
        product91.review = 2.8
        product91.addToReviews(comment1)
        product91.addToReviews(comment2)
        
        let product10 = Product(context: context)
        product10.title = "Watermelon"
        product10.productDetails = "Watermelon, one of summer's most iconic fruits, is low in calories and rich in water. It's also an excellent source of vitamins A and C and lycopene while being less acidic than citrus fruits."
        product10.images = "watemelon"
        product10.price = 5.99
        product10.offer = 20
        product10.oneStar = 29
        product10.twoStar = 45
        product10.threeStar = 11
        product10.fourStar = 58
        product10.fiveStar = 35
        product10.category = Categories.Fruits.rawValue
        product10.nutritions = "One cup of diced watermelon (152g) provides 46 calories, 0.9g of protein, 11.5g of carbohydrates, and 0.2g of fat. Watermelon is an excellent source of lycopene and vitamins A and C."
        product10.review = 3.8
        product10.addToReviews(comment1)
        product10.addToReviews(comment2)
        product10.addToReviews(comment3)
        product10.addToReviews(comment4)
        

        let product11 = Product(context: context)
        product11.title = "Carrot"
        product11.productDetails = " Carrots are root vegetables that were first grown in Afghanistan around 900 AD. Orange may be their best-known color, but they also come in other hues, including purple, yellow, red, and white."
        product11.images = "carrot"
        product11.price = 3.99
        product11.offer = 52
        product11.oneStar = 96
        product11.twoStar = 53
        product11.threeStar = 71
        product11.fourStar = 5
        product11.fiveStar = 26
        product11.category = Categories.Vegetables.rawValue
        product11.nutritions = "They’re good for your eyes. This is probably the best-known carrot superpower. They're rich in beta-carotene, a compound your body changes into vitamin A, which helps keep your eyes healthy."
        product11.review = 2.5
        product11.addToReviews(comment1)
        product11.addToReviews(comment2)
        product11.addToReviews(comment3)
        product11.addToReviews(comment4)
        
        
        
        let product12 = Product(context: context)
        product12.title = "Broccoli "
        product12.productDetails = " Broccoli (Brassica oleracea var. italica) is an edible green plant in the cabbage family (family Brassicaceae, genus Brassica) whose large flowering head, stalk and small associated leaves are eaten as a vegetable."
        product12.images = "brocolli"
        product12.price = 8.99
        product12.offer = 23
        product12.oneStar = 26
        product12.twoStar = 85
        product12.threeStar = 45
        product12.fourStar = 63
        product12.fiveStar = 22
        product12.category = Categories.Vegetables.rawValue
        product12.nutritions = "Broccoli has high levels of glucoraphanin, a compound that is converted into a potent antioxidant called sulforaphane during digestion.Broccoli also contains measurable amounts of the antioxidants lutein and zeaxanthin."
        product12.review = 4.5
        product12.addToReviews(comment2)
        product12.addToReviews(comment1)
        
        let product13 = Product(context: context)
        product13.title = "Peas"
        product13.productDetails = "Peas are in the group of foods known as legumes. Legumes are plants that produce pods with seeds, or beans, inside. Other foods in the legume family include lentils, soybeans, chickpeas, and all types of beans."
        product13.images = "peas"
        product13.price = 7.99
        product13.offer = 23
        product13.oneStar = 86
        product13.twoStar = 33
        product13.threeStar = 57
        product13.fourStar = 89
        product13.fiveStar = 68
        product13.category = Categories.Vegetables.rawValue
        product13.nutritions = "The high concentration of vitamins, minerals, antioxidants, and phytonutrients in peas provides important health benefits that range from keeping your eyes healthy to protecting you against certain cancers."
        product13.review = 4.5
        product13.addToReviews(comment3)
        product13.addToReviews(comment2)
        
        
        let product14 = Product(context: context)
        product14.title = "Potato"
        product14.productDetails = "Potato, Solanum tuberosum, is an herbaceous perennial plant in the family Solanaceae which is grown for its edible tubers. The potato plant has a branched stem and alternately arranged leaves consisting of leaflets which are both of unequal size and shape."
        product14.images = "potato"
        product14.price = 2.99
        product14.offer = 36
        product14.oneStar = 58
        product14.twoStar = 37
        product14.threeStar = 87
        product14.fourStar = 69
        product14.fiveStar = 47
        product14.category = Categories.Vegetables.rawValue
        product14.nutritions = "The tubers are one of the richest sources of the B-complex group of vitamins such as pyridoxine (vitamin B6), thiamin, niacin, pantothenic acid, and folates."
        product14.review = 3.5
        product14.addToReviews(comment2)
        product14.addToReviews(comment4)
        
        
        let product15 = Product(context: context)
        product15.title = "Capsicum"
        product15.productDetails = "Capsicums belong to the same family as the tomato and eggplant. The word capsicum means “box”.Capsicum should be a uniform, glossy colour either bright green or deep red. It should be firm and have thick walls. Depending on the variety, it may be mild, sweet, hot or fiery."
        product15.images = "capsicum"
        product15.price = 7.99
        product15.offer = 52
        product15.oneStar = 96
        product15.twoStar = 32
        product15.threeStar =  69
        product15.fourStar = 22
        product15.fiveStar = 59
        product15.category = Categories.Vegetables.rawValue
        product15.nutritions = "Excellent source of Vitamin C and Vitamin A.Capsicum contains very low fat and is very high in fibre as well as water content."
        product15.review = 2.5
        product15.addToReviews(comment1)
        product15.addToReviews(comment2)
        
        
        let product16 = Product(context: context)
        product16.title = "Pumpkin"
        product16.productDetails = "A pumpkin is a cultivar of winter squash that is round with smooth, slightly ribbed skin, and is most often deep yellow to orange in coloration. The thick shell contains the seeds and pulp."
        product16.images = "pumpkin"
        product16.price = 6.99
        product16.offer = 23
        product16.oneStar = 85
        product16.twoStar = 36
        product16.threeStar = 55
        product16.fourStar = 23
        product16.fiveStar = 68
        product16.category = Categories.Vegetables.rawValue
        product16.nutritions = "Pumpkins contain antioxidants, such as alpha-carotene, beta-carotene and beta-cryptoxanthin. These can neutralize free radicals, stopping them from damaging your cells."
        product16.review = 3.5
        product16.addToReviews(comment5)
        product16.addToReviews(comment2)
        
        
        let product17 = Product(context: context)
        product17.title = "Cabbage"
        product17.productDetails = "Cabbage, comprising several cultivars of Brassica oleracea, is a leafy green, red (purple), or white (pale green) biennial plant grown as an annual vegetable crop for its dense-leaved heads."
        product17.images = "cabbage"
        product17.price = 4.99
        product17.offer = 25
        product17.oneStar = 33
        product17.twoStar = 85
        product17.threeStar = 65
        product17.fourStar = 24
        product17.fiveStar = 72
        product17.category = Categories.Vegetables.rawValue
        product17.nutritions = "Cabbage contains the antioxidants choline, beta-carotene, lutein, and zeaxanthin as well as the flavonoids kaempferol, quercetin, and apigenin."
        product17.review = 4.5
        product17.addToReviews(comment5)
        product17.addToReviews(comment2)
        
        
        let product18 = Product(context: context)
        product18.title = "Cauliflower"
        product18.productDetails = "Cauliflower is one of several vegetables in the species Brassica oleracea in the genus Brassica, which is in the Brassicaceae (or Mustard) family. It is an annual plant that reproduces by seed."
        product18.images = "cauliFlower"
        product18.price = 3.99
        product18.offer = 57
        product18.oneStar = 20
        product18.twoStar = 8
        product18.threeStar = 96
        product18.fourStar = 44
        product18.fiveStar = 38
        product18.category = Categories.Vegetables.rawValue
        product18.nutritions = "It is believed to be so beneficial due to its special combination of phytochemicals called carotenoids, tocopherols and ascorbic acid."
        product18.review = 4.6
        product18.addToReviews(comment7)
        product18.addToReviews(comment5)
        
        
        let product19 = Product(context: context)
        product19.title = "Lettuce"
        product19.productDetails = "Lettuce (Lactuca sativa) is an annual plant of the daisy family, Asteraceae. It is most often grown as a leaf vegetable, but sometimes for its stem and seeds. "
        product19.images = "lettuce"
        product19.price = 8.99
        product19.offer = 22
        product19.oneStar = 74
        product19.twoStar = 62
        product19.threeStar = 16
        product19.fourStar = 60
        product19.fiveStar = 26
        product19.category = Categories.Vegetables.rawValue
        product19.nutritions = "Lettuce is a source of vitamin K, which helps strengthen bones. Consuming adequate amounts of vitamin K can also reduce your risk of bone fracture."
        product19.review = 3.4
        product19.addToReviews(comment4)
        product19.addToReviews(comment2)
        
        
        let product20 = Product(context: context)
        product20.title = "Mushroom"
        product20.productDetails = "A mushroom or toadstool is the fleshy, spore-bearing fruiting body of a fungus, typically produced above ground, on soil, or on its food source."
        product20.images = "mushroom"
        product20.price = 9.99
        product20.offer = 85
        product20.oneStar = 90
        product20.twoStar = 75
        product20.threeStar = 63
        product20.fourStar = 58
        product20.fiveStar = 93
        product20.category = Categories.Vegetables.rawValue
        product20.nutritions = "Mushrooms are the leading source of the antioxidant nutrient selenium in the produce aisle.In addition, mushrooms provide ergothioneine, a naturally occurring antioxidant that may help protect the body’s cells."
        product20.review = 4.8
        product20.addToReviews(comment3)
        product20.addToReviews(comment2)
        
        
        let product31 = Product(context: context)
        product31.title = "Chicken"
        product31.productDetails = "chicken is a different classification of meat and comes under the poultry category.People commonly refer to poultry as ‘white meat’."
        product31.images = "chicken"
        product31.price = 5.99
        product31.offer = 10
        product31.oneStar = 89
        product31.twoStar = 35
        product31.threeStar = 28
        product31.fourStar = 45
        product31.fiveStar = 97
        product31.category = Categories.Meat.rawValue
        product31.nutritions = "Chicken provides a decent source of necessary vitamins and minerals, particularly selenium, potassium, phosphorus and B vitamins."
        product31.review = 4.8
        product31.addToReviews(comment2)
        product31.addToReviews(comment4)
        
        let product32 = Product(context: context)
        product32.title = "Mutton"
        product32.productDetails = "Mutton is the meat of an adult sheep.It contains many protein content which forms a major part in our diet."
        product32.images = "mutton"
        product32.price = 8.99
        product32.offer = 10
        product32.oneStar = 25
        product32.twoStar = 95
        product32.threeStar = 38
        product32.fourStar = 57
        product32.fiveStar = 98
        product32.category = Categories.Meat.rawValue
        product32.nutritions = " Mutton contains a broad range of health-protective nutrients, especially zinc, selenium and B vitamins."
        product32.review = 3.8
        product32.addToReviews(comment6)
        product32.addToReviews(comment3)
        
        
        let product33 = Product(context: context)
        product33.title = "Fish"
        product33.productDetails = "Fish meat has been an important dietary source of protein and other nutrients throughout human history.The dietary contribution of fish is significant in terms of high-quality, easily digested animal proteins and especially in fighting micronutrient deficiencies."
        product33.images = "fish-1"
        product33.price = 7.99
        product33.offer = 15
        product33.oneStar = 50
        product33.twoStar = 95
        product33.threeStar = 58
        product33.fourStar = 87
        product33.fiveStar = 88
        product33.category = Categories.Meat.rawValue
        product33.nutritions = " Eating oily fish containing long-chain omega-3 fatty acids may reduce systemic inflammation and lower the risk of cardiovascular disease. Increasing intake of omega-3 fatty acids may slightly reduce the risk of a fatal heart attack."
        product33.review = 4.5
        product33.addToReviews(comment5)
        product33.addToReviews(comment2)
        
        
        let product34 = Product(context: context)
        product34.title = "Gingelly oil"
        product34.productDetails = "Gingelly oil, also known as sesame seed oil, is prized worldwide for its culinary and medicinal properties. Rich in antioxidants and healthy fats, it reduces oxidative stress, fights inflammation, and supports cardiovascular health. It can also be applied to the skin to improve texture and elasticity."
        product34.images = "gingellyOil"
        product34.price = 5.99
        product34.offer = 25
        product34.oneStar = 86
        product34.twoStar = 35
        product34.threeStar = 96
        product34.fourStar = 27
        product34.fiveStar = 36
        product34.category = Categories.Oils.rawValue
        product34.nutritions = " It's also an excellent source of omega-3 and omega-6 essential fatty acids.With its high antioxidant content, gingelly oil protects against oxidative stress and neutralizes free radicals."
        product34.review = 4.8
        product34.addToReviews(comment1)
        product34.addToReviews(comment3)
        
        let product35 = Product(context: context)
        product35.title = "Castor oil"
        product35.productDetails = "Castor oil is a multipurpose vegetable oil that people have used for thousands of years. It’s made by extracting oil from the seeds of the Ricinus communis plant.These seeds, which are known as castor beans, contain a toxic enzyme called ricin."
        product35.images = "castor"
        product35.price = 4.99
        product35.offer = 85
        product35.oneStar = 35
        product35.twoStar = 72
        product35.threeStar = 66
        product35.fourStar = 27
        product35.fiveStar = 98
        product35.category = Categories.Oils.rawValue
        product35.nutritions = "castor oil contains therapeutic components including fatty acids, flavonoids, phenolic compounds, amino acids, terpenoids and phytosterols."
        product35.review = 4.4
        product35.addToReviews(comment4)
        product35.addToReviews(comment2)
        
        let product36 = Product(context: context)
        product36.title = "Almond oil"
        product36.productDetails = "Almonds are the edible seeds of the Prunus dulcis tree, more commonly known as the almond tree.Unrefined almond oil is made by pressing raw almonds without the use of high heat or chemical agents."
        product36.images = "almond"
        product36.price = 8.99
        product36.offer = 53
        product36.oneStar = 75
        product36.twoStar = 38
        product36.threeStar = 16
        product36.fourStar = 98
        product36.fiveStar = 72
        product36.category = Categories.Oils.rawValue
        product36.nutritions = "Almond oil is a good source of the antioxidant vitamin E and unsaturated fats. Diets rich in unsaturated fat may provide some health benefits, including a reduced risk of heart disease and obesity, and they may aid weight loss."
        product36.review = 4.7
        product36.addToReviews(comment3)
        product36.addToReviews(comment1)
        
        
        let product37 = Product(context: context)
        product37.title = "Coconut oil"
        product37.productDetails = "Coconut oil is made by pressing dried coconut meat, called copra, or fresh coconut meat. To make it, you can use a “dry” or “wet” method.The milk and oil from the coconut are pressed, and then the oil is removed. It has a firm texture at cool or room temperatures because the fats in the oil, which are mostly saturated fats, are made up of smaller molecules."
        product37.images = "cocunent"
        product37.price = 6.99
        product37.offer = 57
        product37.oneStar = 37
        product37.twoStar = 76
        product37.threeStar = 96
        product37.fourStar = 35
        product37.fiveStar = 45
        product37.category = Categories.Oils.rawValue
        product37.nutritions = "coconut are made up of these three healthy fatty acids, and 91 percent of the fat in coconut oil is healthy saturated fat. This fat composition makes it one of the most beneficial fats on the planet."
        product37.review = 4.9
        product37.addToReviews(comment3)
        product37.addToReviews(comment2)
        
        let product38 = Product(context: context)
        product38.title = "Olive oil"
        product38.productDetails = "Olive oil is the natural oil extracted from olives, the fruit of the olive tree.Extra virgin olive oil is loaded with antioxidants,some of which have powerful biological effects."
        product38.images = "olive"
        product38.price = 8.99
        product38.offer = 38
        product38.oneStar = 79
        product38.twoStar = 24
        product38.threeStar = 57
        product38.fourStar = 22
        product38.fiveStar = 37
        product38.category = Categories.Oils.rawValue
        product38.nutritions = "Olive oil is rich in monounsaturated oleic acid. This fatty acid is believed to have many beneficial effects and is a healthy choice for cooking."
        product38.review = 4.7
        product38.addToReviews(comment5)
        product38.addToReviews(comment2)
        

        let product39 = Product(context: context)
        product39.title = "Breads"
        product39.productDetails = "Breads are one of the oldest forms of food in the world and are made by baking dough, a flour and water mixture. Other ingredients such as salt, fat, milk, sugar, baking soda and yeast can be added."
        product39.images = "bread"
        product39.price = 2.99
        product39.offer = 50
        product39.oneStar = 96
        product39.twoStar = 75
        product39.threeStar = 25
        product39.fourStar = 37
        product39.fiveStar = 71
        product39.category = Categories.Bakery.rawValue
        product39.nutritions = "Bread, wheat contains 0.2 g of saturated fat and 0 mg of cholesterol per serving. 29 g of Bread, wheat contains IU vitamin A, 0.1 mg of vitamin C and 0.00 mcg of vitamin D as well as 1.04 mg of iron, 36.25 mg of calcium and 41 mg of potassium."
        product39.review = 4.9
        product39.addToReviews(comment2)
        product39.addToReviews(comment3)
        
        let product40 = Product(context: context)
        product40.title = "Doughnuts"
        product40.productDetails = "Doughnuts provide a tasty snack and can be eaten for breakfast. Usually sweet and deep fried, doughnuts come with a hole in the middle or as a solid piece filled with items such as jelly, creams or custards. Doughnuts can be baked in an oven instead of deep fried."
        product40.images = "dougnuts"
        product40.price = 5.99
        product40.offer = 50
        product40.oneStar = 38
        product40.twoStar = 72
        product40.threeStar = 65
        product40.fourStar = 95
        product40.fiveStar = 27
        product40.category = Categories.Bakery.rawValue
        product40.nutritions = "Powdered doughnuts also contain 13 g of sugar and 4 g of protein, along with 4 percent of suggested daily values of vitamin A, 2 percent of calcium and 6 percent of iron."
        product40.review = 4.2
        product40.addToReviews(comment5)
        product40.addToReviews(comment7)
        
        let product41 = Product(context: context)
        product41.title = "Pies"
        product41.productDetails = "Bakeries sell pies as dessert items. A pie is a baked dish consisting of layers of pastry dough that form a shell and have sweet or sour fillings. Pies can also be filled with meat and eaten as a dinner, however such pies are rarely found in bakeries."
        product41.images = "pies"
        product41.price = 7.99
        product41.offer = 24
        product41.oneStar = 92
        product41.twoStar = 37
        product41.threeStar = 55
        product41.fourStar = 43
        product41.fiveStar = 28
        product41.category = Categories.Bakery.rawValue
        product41.nutritions = "The favorite choice for the term is 1 piece of Apple Pie which has about 400 calories.However, a portion of calories in pies and cakes can also be from healthy ingredients such as eggs, which contain proteins and nutrients."
        product41.review = 4.1
        product41.addToReviews(comment3)
        product41.addToReviews(comment5)
        
        
        let product42 = Product(context: context)
        product42.title = "Pastries"
        product42.productDetails = "Pastries refer to baked goods made with ingredients that often include butter, sugar, shortening, flour, baking powder and eggs. Pastries, higher in fat content than breads, include small desserts and quiches. Other types include Danish pastry and croissants."
        product42.images = "pastries"
        product42.price = 9.99
        product42.offer = 54
        product42.oneStar = 38
        product42.twoStar = 72
        product42.threeStar = 85
        product42.fourStar = 96
        product42.fiveStar = 24
        product42.category = Categories.Bakery.rawValue
        product42.nutritions = "Pastries and baked goods are typically made with all-purpose or whole-wheat flour which is very high in carbohydrate content. The vitamin and mineral content may be increased in these items by using fortified flours"
        product42.review = 4.5
        product42.addToReviews(comment2)
        product42.addToReviews(comment4)
        

        let product44 = Product(context: context)
        product44.title = "Seer fish"
        product44.productDetails = "Vanjaram fish is one of the most expensive fish in India, especially in Central and South India for its delicacy. The fish is also known as seer fish, king mackerel, or indo-pacific mackerel. From the common names, we know that vanjaram is a type of mackerel fish."
        product44.images = "seer"
        product44.price = 8.99
        product44.offer = 85
        product44.oneStar = 96
        product44.twoStar = 27
        product44.threeStar = 72
        product44.fourStar = 38
        product44.fiveStar = 42
        product44.category = Categories.Fish.rawValue
        product44.nutritions = "Vanjaram fish is very good for eyes as it contains high levels of omega-3 and vitamin A. omega-3 is able to prevent macular degeneration disease which attack retina. It also prevents the blurred vision. On the other hand, vitamin A improves the night vision effectively."
        product44.review = 4.9
        product44.addToReviews(comment2)
        product44.addToReviews(comment4)
        
        let product45 = Product(context: context)
        product45.title = "Rohu fish"
        product45.productDetails = "Rohu fish belly is in silver color and there is a total of 7 fins in the body of Rohu fish. The max length that Rohu fish can attain is 1 meter."
        product45.images = "rohu"
        product45.price = 4.99
        product45.offer = 50
        product45.oneStar = 38
        product45.twoStar = 45
        product45.threeStar = 25
        product45.fourStar = 93
        product45.fiveStar = 27
        product45.category = Categories.Fish.rawValue
        product45.nutritions = "Rohu is enriched with a handsome amount of protein. Packed with Omega 3 fatty acids and vitamins A, B, and C."
        product45.review = 3.5
        product45.addToReviews(comment2)
        product45.addToReviews(comment3)
        
        
        let product46 = Product(context: context)
        product46.title = "Katla"
        product46.productDetails = "Katla is a fish with large and broad head, a large protruding lower jaw and upturned mouth. It has large, greyish scales on dorsal side and whitish on belly."
        product46.images = "katla"
        product46.price = 6.99
        product46.offer = 20
        product46.oneStar = 82
        product46.twoStar = 38
        product46.threeStar = 93
        product46.fourStar = 72
        product46.fiveStar = 52
        product46.category = Categories.Fish.rawValue
        product46.nutritions = "It provides a respected amount of fish protien,omega 3 fatty acid,vit a,calcium etc. which are good for health."
        product46.review = 4.4
        product46.addToReviews(comment1)
        product46.addToReviews(comment3)

        let product47 = Product(context: context)
        product47.title = "Corn"
        product47.productDetails = "Corn has the highest level of antioxidants of any grain or vegetable!. It has almost twice the antioxidant activity of apples.It helps to prevent cardiovascular disease, diabetes, and cancer and other chronic diseases."
        product47.images = "corn"
        product47.price = 2.99
        product47.offer = 60
        product47.oneStar = 85
        product47.twoStar = 35
        product47.threeStar = 96
        product47.fourStar = 72
        product47.fiveStar = 28
        product47.category = Categories.FoodGrains.rawValue
        product47.nutritions = "It is rich in magnesium, phosphorus, manganese, and selenium."
        product47.review = 4.8
        product47.addToReviews(comment7)
        product47.addToReviews(comment5)
        
        let product48 = Product(context: context)
        product48.title = "Wheat"
        product48.productDetails = "Wheat is a grass widely cultivated for its seed, a cereal grain which is a worldwide staple food. The many species of wheat together make up the genus Triticum; the most widely grown is common wheat"
        product48.images = "wheat"
        product48.price = 5.99
        product48.offer = 50
        product48.oneStar = 96
        product48.twoStar = 28
        product48.threeStar = 66
        product48.fourStar = 79
        product48.fiveStar = 18
        product48.category = Categories.FoodGrains.rawValue
        product48.nutritions = "On an average, the kernel contains 12 percent water, 70 percent carbohydrates, 12 percent protein, 2 percent fat, 1.8 percent minerals, and 2.2 percent crude fibres."
        product48.review = 4.2
        product48.addToReviews(comment3)
        product48.addToReviews(comment4)
        
        
        let product49 = Product(context: context)
        product49.title = "Rice"
        product49.productDetails = "Rice (Oryza sativa) is one of the oldest cereal grains in the world, and people have grown it for at least 5,000 years.Rice is a staple food for more than halfTrusted Source of the world’s population, and 90% of the world’s rice comes from Asia."
        product49.images = "rice-1"
        product49.price = 8.99
        product49.offer = 25
        product49.oneStar = 38
        product49.twoStar = 72
        product49.threeStar = 36
        product49.fourStar = 79
        product49.fiveStar = 38
        product49.category = Categories.FoodGrains.rawValue
        product49.nutritions = "Both white and brown rice contain mainly carbohydrate and some protein, with virtually no fat or sugar.Cooked rice contains a lot of water, making up almost 70% of its total weight."
        product49.review = 4.8
        product49.addToReviews(comment5)
        product49.addToReviews(comment4)
        
        let product50 = Product(context: context)
        product50.title = "Barley"
        product50.productDetails = "Barley (Hordeum vulgare), a member of the grass family, is a major cereal grain grown in temperate climates globally. It was one of the first cultivated grains, particularly in Eurasia."
        product50.images = "barley"
        product50.price = 5.99
        product50.offer = 28
        product50.oneStar = 71
        product50.twoStar = 39
        product50.threeStar = 92
        product50.fourStar = 80
        product50.fiveStar = 46
        product50.category = Categories.FoodGrains.rawValue
        product50.nutritions = "Barley has a nutlike flavour and is high in carbohydrates, with moderate quantities of protein, calcium, and phosphorus and small amounts of the B vitamins."
        product50.review = 4.4
        product50.addToReviews(comment4)
        product50.addToReviews(comment5)
        
        
        let product51 = Product(context: context)
        product51.title = "Oats"
        product51.productDetails = "The oat (Avena sativa), sometimes called the common oat, is a species of cereal grain grown for its seed, which is known by the same name (usually in the plural, unlike other cereals and pseudocereals)."
        product51.images = "oats"
        product51.price = 2.99
        product51.offer = 97
        product51.oneStar = 52
        product51.twoStar = 76
        product51.threeStar = 32
        product51.fourStar = 91
        product51.fiveStar = 55
        product51.category = Categories.FoodGrains.rawValue
        product51.nutritions = "The grains are high in carbohydrates and contain about 13 percent protein and 7.5 percent fat. They are a source of calcium, iron, vitamin B1, and niacin."
        product51.review = 4.2
        product51.addToReviews(comment5)
        product51.addToReviews(comment3)
        
        let product52 = Product(context: context)
        product52.title = "Ragi"
        product52.productDetails = "Ragi is an ancient and famous grain mostly popular in India. The scientific name of Ragi or Finger Millet is Eleusine coracana. It was mainly used in the southern part of India. But nowadays people have started using ragi regularly in their diet."
        product52.images = "ragi"
        product52.price = 6.99
        product52.offer = 25
        product52.oneStar = 96
        product52.twoStar = 27
        product52.threeStar = 22
        product52.fourStar = 37
        product52.fiveStar = 25
        product52.category = Categories.FoodGrains.rawValue
        product52.nutritions = "It is rich in dietary fibres, proteins, potassium, and carbohydrates. Minerals such as calcium and iron are abundant in Ragi flour. Besides, vitamins such as thiamine and riboflavin are also present"
        product52.review = 2.5
        product52.addToReviews(comment5)
        product52.addToReviews(comment6)
        
        let product53 = Product(context: context)
        product53.title = "Chickpea"
        product53.productDetails = "The chickpea or chick pea (Cicer arietinum) is an annual legume of the family Fabaceae, subfamily Faboideae. Its different types are variously known as gram or Bengal gram, garbanzo or garbanzo bean, or Egyptian pea."
        product53.images = "chickpea"
        product53.price = 5.99
        product53.offer = 15
        product53.oneStar = 28
        product53.twoStar = 72
        product53.threeStar = 52
        product53.fourStar = 77
        product53.fiveStar = 52
        product53.category = Categories.FoodGrains.rawValue
        product53.nutritions = " An excellent source of carbohydrate, protein, fiber, B vitamins, and some minerals, they are a nutritious staple of many diets."
        product53.review = 4.5
        product53.addToReviews(comment7)
        product53.addToReviews(comment1)
        
        
        let product54 = Product(context: context)
        product54.title = "Quinoa"
        product54.productDetails = "Quinoa (Chenopodium quinoa;, from Quechua kinwa or kinuwa) is a flowering plant in the amaranth family. It is a herbaceous annual plant grown as a crop primarily for its edible seeds."
        product54.images = "quinoa"
        product54.price = 7.99
        product54.offer = 10
        product54.oneStar = 91
        product54.twoStar = 73
        product54.threeStar = 22
        product54.fourStar = 69
        product54.fiveStar = 74
        product54.category = Categories.FoodGrains.rawValue
        product54.nutritions = "The seeds are rich in protein, dietary fiber, B vitamins, and dietary minerals in amounts greater than in many grains."
        product54.review = 4.1
        product54.addToReviews(comment6)
        product54.addToReviews(comment5)
        
        let product55 = Product(context: context)
        product55.title = "Sorghum"
        product55.productDetails = "Sorghum is a genus of about 25 species of flowering plants in the grass family (Poaceae). Some of these species are grown as cereals for human consumption and some in pastures for animals"
        product55.images = "sorgham"
        product55.price = 5.99
        product55.offer = 17
        product55.oneStar = 20
        product55.twoStar = 12
        product55.threeStar = 92
        product55.fourStar = 82
        product55.fiveStar = 38
        product55.category = Categories.FoodGrains.rawValue
        product55.nutritions = "Sorghum boasts an impressive nutrient profile. It’s a significant source of many vitamins and minerals, fiber, and protein, all of which contribute to good health."
        product55.review = 4.9
        product55.addToReviews(comment2)
        product55.addToReviews(comment4)
        
        let product56 = Product(context: context)
        product56.title = "Mung bean"
        product56.productDetails = "The mung bean (Vigna radiata), alternatively known as the green gram, maash, moong, monggo, or munggo (Philippines), is a plant species in the legume family."
        product56.images = "mung"
        product56.price = 6.99
        product56.offer = 11
        product56.oneStar = 86
        product56.twoStar = 72
        product56.threeStar = 32
        product56.fourStar = 91
        product56.fiveStar = 52
        product56.category = Categories.FoodGrains.rawValue
        product56.nutritions = "Mung beans are an excellent source of fiber, potassium, copper, and B vitamins."
        product56.review = 4.3
        product56.addToReviews(comment2)
        product56.addToReviews(comment3)
        
        
        
        let userx = User(context: context)
        userx.name = "Ajithmadhan k"
        userx.password = "aspirine"
        userx.email = "ajith.madhan@zohocorp.com"
        userx.phone = "7448308493"
        userx.address = "30/A Mahalingapuram Pollachi - 642002"
        userx.userImage = UIImage(named: "defaultUser")?.pngData()
        userx.addToRecentSearches(product4)
        userx.addToRecentSearches(product6)
        userx.addToRecentSearches(product5)
        
        let coupon = Coupons(context: context)
        coupon.code = "HAPPY10"
        coupon.discount = 10
        coupon.treshHold = 10
        
        let coupon1 = Coupons(context: context)
        coupon1.code = "FIRSTFREEBEE"
        coupon1.discount = 100
        coupon1.treshHold = 100
        
        let coupon2 = Coupons(context: context)
        coupon2.code = "DIWALI60"
        coupon2.discount = 60
        coupon2.treshHold = 20
        
        let coupon3 = Coupons(context: context)
        coupon3.code = "SUMMAR60"
        coupon3.discount = 60
        coupon3.treshHold = 66
        
        let coupon4 = Coupons(context: context)
        coupon4.code = "TAMIL20"
        coupon4.discount = 20
        coupon4.treshHold = 50
        
        let search = RecentText(context: context)
        search.search = "lemon"
        
        let search2 = RecentText(context: context)
        search2.search = "mango"
        
        let search3 = RecentText(context: context)
        search3.search = "orange"
        
        
        
        do{
            try context.save()
        }catch{
            print("Error Saving data")
        }
        
        
    }
    
    
    
 
    
}
