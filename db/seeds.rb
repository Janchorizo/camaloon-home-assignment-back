# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
product_types = ProductType.create([
    {
        name: "Bikes",
        description: "The very essence of cycling. Off-road, trail, and road bicycles.",
        hidden: false
    },
    {
        name: "Wheels",
        description: "The best trims and tires to keep you on track.",
        hidden: false
    },
    {
        name: "Clothing",
        description: "Durable, transpirable and ergonomic cycling clothes.",
        hidden: false
    },
])

products = Product.create([
    {
        name: "Orbea Loki 26.5",
        description: "Off-road hardtail mountain bike that will give you plenty of fun.",
        product_type: product_types[0],
        base_price: 700,
        hidden: false
    },
    {
        name: "Orbea Loki 27\"",
        description: "Off-road hardtail mountain bike that will give you plenty of fun.",
        product_type: product_types[0],
        base_price: 800,
        hidden: false
    },
    {
        name: "Orbea Loki 29\"",
        description: "Off-road hardtail mountain bike that will give you plenty of fun.",
        product_type: product_types[0],
        base_price: 875,
        hidden: false
    },
    {
        name: "Yeti SB140",
        description: "27.5\" full suspension state-of-the-art mountain bike. An incredible experience",
        product_type: product_types[0],
        base_price: 3500,
        hidden: false
    },
    {
        name: "Maxxis Receptor",
        description: "Gravel tire with a smooth slick central tube.",
        product_type: product_types[1],
        base_price: 63,
        hidden: false
    },
    {
        name: "Maxxis All Terrane",
        description: "An all-around good tire.",
        product_type: product_types[1],
        base_price: 63,
        hidden: false
    },
    {
        name: "Maxxis Ravager",
        description: "Good for both trails and gravel.",
        product_type: product_types[1],
        base_price: 63,
        hidden: false
    },
    {
        name: "Our jacket",
        description: "A nice jacket",
        product_type: product_types[2],
        base_price: 50,
        hidden: false
    },
    {
        name: "Helmet",
        description: "An important security meassure.",
        product_type: product_types[2],
        base_price: 35,
        hidden: false
    }
])
customization_types = CustomizationType.create([
    {
        name: "Frame color",
        description: "Even though the looks don't affect the ride, giving it a personalized look is always cool.",
        product_type: product_types[0]
    },
    {
        name: "Yeti SB140 kit",
        description: "Shift, rear shock, wheelset, material and fork. A complete new experience for the same model.",
        product_type: product_types[0]
    },
    {
        name: "Tubeless ready",
        description: "Forget about the hassle of setting it up and get your bike with the wheels tubeless already.",
        product_type: product_types[0]
    },
    {
        name: "Wheel size",
        description: "Check your frame and wheelset to better choose what size fits your bike.",
        product_type: product_types[1]
    },
    {
        name: "Jacket size",
        description: "The length is meassured from the hip to the neck.",
        product_type: product_types[2]
    },
    {
        name: "Jacket color",
        description: "Choose the color that best fits.",
        product_type: product_types[2]
    }
])
manufacturers = Manufacturer.create([
    {
        name: "Orbea",
        cif: "orbeacif",
        email: "orbea@orbea.orbea",
        phone: 666666666
    },
    {
        name: "Yeti",
        cif: "yeticif",
        email: "yeti@yeti.yeti",
        phone: 666666666
    },
    {
        name: "Maxxis",
        cif: "maxxiscif",
        email: "maxxis@maxxis.maxxis",
        phone: 666666666
    },
    {
        name: "Wheelshop",
        cif: "wheelscif",
        email: "wheels@wheels.wheels",
        phone: 666666666
    },
    {
        name: "Bikeshop",
        cif: "shopcif",
        email: "shop@shop.shop",
        phone: 666666666
    },
])
choices = CustomizationChoice.create([
    {
        name: 'Red',
        description: 'Red frame color',
        model_ref: 'red',
        manufacturer: manufacturers[4],
        customization_type: customization_types[0],
        extra_cost: 15
    },
    {
        name: 'Cyan',
        description: 'Cyan frame color',
        model_ref: 'cyan',
        manufacturer: manufacturers[4],
        customization_type: customization_types[0],
        extra_cost: 15
    },
    {
        name: 'Black',
        description: 'Black frame color',
        model_ref: 'blk',
        manufacturer: manufacturers[4],
        customization_type: customization_types[0],
        extra_cost: 0
    },
    {
        name: 'T3 TURQ',
        description: 'TURQ Series carbon fiber frame, Switch Infinity suspension technology, press-fit BB92, internally tunneled cable routing, 148mm x 12mm BOOST dropouts, sealed enduro max pivot bearings, integrated derailleur hanger, and axle.',
        model_ref: 'ref-y-1',
        manufacturer: manufacturers[1],
        customization_type: customization_types[1],
        extra_cost: 5100
    },
    {
        name: 'T2 TURQ',
        description: 'TURQ Series carbon fiber frame, Switch Infinity suspension technology, press-fit BB92, internally tunneled cable routing, 148mm x 12mm BOOST dropouts, sealed enduro max pivot bearings, integrated derailleur hanger, and axle.',
        model_ref: 'ref-y-2',
        manufacturer: manufacturers[1],
        customization_type: customization_types[1],
        extra_cost: 3900
    },
    {
        name: 'T1 TURQ',
        description: 'TURQ Series carbon fiber frame, Switch Infinity suspension technology, press-fit BB92, internally tunneled cable routing, 148mm x 12mm BOOST dropouts, sealed enduro max pivot bearings, integrated derailleur hanger, and axle.',
        model_ref: 'ref-y-1',
        manufacturer: manufacturers[1],
        customization_type: customization_types[1],
        extra_cost: 3400
    },
    {
        name: 'no',
        description: 'Traditional rubber air chamber.',
        model_ref: 'shop-not-tubeless',
        manufacturer: manufacturers[4],
        customization_type: customization_types[2],
        extra_cost: 0
    },
    {
        name: 'yes',
        description: 'Tubeless setup, already sealed and inflated.',
        model_ref: 'shop-tubeless',
        manufacturer: manufacturers[4],
        customization_type: customization_types[2],
        extra_cost: 40
    },
    {
        name: '26"',
        description: 'Small, technical wheel size with a diameter of 26 inches',
        model_ref: 'wheel-26"',
        manufacturer: manufacturers[3],
        customization_type: customization_types[3],
        extra_cost: 0
    },
    {
        name: '27.5"',
        description: 'Medium wheel size with a diameter of 27.5 inches',
        model_ref: 'wheel-27.5"',
        manufacturer: manufacturers[3],
        customization_type: customization_types[3],
        extra_cost: 10
    },
    {
        name: '29"',
        description: 'large wheel size with a diameter of 29 inches',
        model_ref: 'wheel-29"',
        manufacturer: manufacturers[3],
        customization_type: customization_types[3],
        extra_cost: 10
    },
    {
        name: 's',
        description: 'Small size',
        model_ref: 'jacket-s',
        manufacturer: manufacturers[4],
        customization_type: customization_types[4],
        extra_cost: 0
    },
    {
        name: 'm',
        description: 'Medium size',
        model_ref: 'jacket-m',
        manufacturer: manufacturers[4],
        customization_type: customization_types[4],
        extra_cost: 0
    },
    {
        name: 'l',
        description: 'Large size',
        model_ref: 'jacket-l',
        manufacturer: manufacturers[4],
        customization_type: customization_types[4],
        extra_cost: 0
    },
])
puts(choices)
ProductChoiceLine.create([
    {
        product: products[0],
        customization_choice: choices[0]
    },
    {
        product: products[0],
        customization_choice: choices[2]
    },
    {
        product: products[1],
        customization_choice: choices[0]
    },
    {
        product: products[1],
        customization_choice: choices[2]
    },
    {
        product: products[2],
        customization_choice: choices[0]
    },
    {
        product: products[2],
        customization_choice: choices[2]
    },
    {
        product: products[3],
        customization_choice: choices[1]
    },
    {
        product: products[3],
        customization_choice: choices[2]
    },
    {
        product: products[3],
        customization_choice: choices[3]
    },
    {
        product: products[3],
        customization_choice: choices[4]
    },
    {
        product: products[3],
        customization_choice: choices[5]
    },
    {
        product: products[4],
        customization_choice: choices[6]
    },
    {
        product: products[4],
        customization_choice: choices[7]
    },
    {
        product: products[4],
        customization_choice: choices[8]
    },
    {
        product: products[4],
        customization_choice: choices[9]
    },
    {
        product: products[4],
        customization_choice: choices[10]
    },
    {
        product: products[5],
        customization_choice: choices[6]
    },
    {
        product: products[5],
        customization_choice: choices[7]
    },
    {
        product: products[5],
        customization_choice: choices[9]
    },
    {
        product: products[5],
        customization_choice: choices[10]
    },
    {
        product: products[6],
        customization_choice: choices[6]
    },
    {
        product: products[6],
        customization_choice: choices[7]
    },
    {
        product: products[6],
        customization_choice: choices[9]
    },
    {
        product: products[6],
        customization_choice: choices[10]
    },
    {
        product: products[7],
        customization_choice: choices[11]
    },
    {
        product: products[7],
        customization_choice: choices[12]
    },
    {
        product: products[7],
        customization_choice: choices[13]
    },
])