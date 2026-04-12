card_number = "1586 4811 6500 5419";
card_holder_name = "ERIK ERIKSSON";


w = 85.60;
h = 53.98;
d = 0.76;
corner_radius = 3.0;

stripe_offset = 5.7;
stripe_h = 9.5;
// Just so it takes one print layer
stripe_d = 0.1;
///cube([w, h, d], true);

font_name = "Verdana";
text_d = 0.4;
text_left_offset = 7.5;
card_number_h = 4.5;
// Offset from text bottom
card_number_offset = 35;
card_holder_h = 3;
card_holder_offset = 47;

//square([w, h], true);

// Card
color("lightblue")
difference() {
    // Card shape
    linear_extrude(d) hull() {
        for (i = [-1:1]) {
            for (j = [-1:1]) {
                translate([
                    i*(w/2 - corner_radius),
                    j*(h/2 - corner_radius)])
                circle(corner_radius, $fn=50);
            }
        }
    };
    
    // Cut a space for the stripe
    // Translate and scale to make the stripe's surface extend beyond the
    // card surfaces, to avoid any overlapping effects
    translate([0,0,-stripe_d])
    scale([2,1,2])
    stripe();
}

// Stripe
stripe();

module stripe() {
//color("black") 
    translate([
    0,
    (h-stripe_h)/2 - stripe_offset,
    0
    ])
linear_extrude(stripe_d)
square([w, stripe_h], true);
}

// Card number
color("gray")
translate([
    -w/2 + text_left_offset,
    h/2 - card_number_offset,
    d])
linear_extrude(text_d)
text(card_number, card_number_h, font_name, halign = "left");

// Card holder
color("gray")
translate([
    -w/2 + text_left_offset,
    h/2 - card_holder_offset,
    d])
linear_extrude(text_d)
text(card_holder_name, card_holder_h, font_name, halign = "left");
