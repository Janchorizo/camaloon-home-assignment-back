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
        description: "The very essence of cycling. Off-road, trail, and road bicycles."
    },
    {
        name: "Wheels",
        description: "The best trims and tires to keep you on track."
    },
    {
        name: "Clothing",
        description: "Durable, transpirable and ergonomic cycling clothes."
    },
])

products = Product.create([
    {
        name: "Orbea Loki 26.5",
        description: "Off-road hardtail mountain bike that will give you plenty of fun.",
        product_type_id: product_types[0].id,
        base_price: 700,
        hidden: !true
    },
    {
        name: "Orbea Loki 27\"",
        description: "Off-road hardtail mountain bike that will give you plenty of fun.",
        product_type_id: product_types[0].id,
        base_price: 800,
        hidden: !true
    },
    {
        name: "Orbea Loki 29\"",
        description: "Off-road hardtail mountain bike that will give you plenty of fun.",
        product_type_id: product_types[0].id,
        base_price: 875,
        hidden: !true
    },
    {
        name: "Yeti SB140",
        description: "27.5\" full suspension state-of-the-art mountain bike. An incredible experience",
        product_type_id: product_types[0].id,
        base_price: 3500,
        hidden: !true
    },
    {
        name: "Maxxis Receptor",
        description: "Gravel tire with a smooth slick central tube.",
        product_type_id: product_types[1].id,
        base_price: 63,
        hidden: !true
    },
    {
        name: "Maxxis All Terrane",
        description: "An all-around good tire.",
        product_type_id: product_types[1].id,
        base_price: 63,
        hidden: !true
    },
    {
        name: "Maxxis Ravager",
        description: "Good for both trails and gravel.",
        product_type_id: product_types[1].id,
        base_price: 63,
        hidden: !true
    },
    {
        name: "Our jacket",
        description: "A nice jacket",
        product_type_id: product_types[2].id,
        base_price: 50,
        hidden: !true
    },
    {
        name: "Helmet",
        description: "An important security meassure.",
        product_type_id: product_types[2].id,
        base_price: 35,
        hidden: !true
    }
])
customization_types = CustomizationType.create([
    {
        name: "Frame color",
        description: "Even though the looks don't affect the ride, giving it a personalized look is always cool.",
        product_type_id: product_types[0].id
    },
    {
        name: "Yeti SB140 kit",
        description: "Shift, rear shock, wheelset, material and fork. A complete new experience for the same model.",
        product_type_id: product_types[0].id
    },
    {
        name: "Tubeless ready",
        description: "Forget about the hassle of setting it up and get your bike with the wheels tubeless already.",
        product_type_id: product_types[0].id
    },
    {
        name: "Wheel size",
        description: "Check your frame and wheelset to better choose what size fits your bike.",
        product_type_id: product_types[1].id
    },
    {
        name: "Jacket size",
        description: "The length is meassured from the hip to the neck.",
        product_type_id: product_types[2].id
    },
    {
        name: "Jacket color",
        description: "Choose the color that best fits.",
        product_type_id: product_types[2].id
    }
])
#Manufacturer.create(
#    {
#        name: "",
#        cif: "",
#        email: "",
#        phone: ""
#    }
#)
#CustomizationChoice.create(
#    {
#        
#    }
#)
#ProductChoiceLine.create(
#    {
#        
#    }
#)