ifn main() {
    println!("Hello, world!");

    // primitive data types
    // inetegers
    let x: i32 = -42;
    let y: u64 = 100;

    println!("Signed integer {} ", x);
    println!("Unsigned integer {} ", y);

    // float
    //  f32
    //  f64
    let pi: f32 = 3.14;
    println!("PI value {}", pi);

    // bool
    let is_done: bool = true;
    println!("Is done {} ", is_done);

    // char
    let leter:char = 'a';
    println!("Letter {} ", leter); 

    // compound data types
    // arrays
    // tupples
    // slices
    // strings (slice string)
    
    let numbers: [i32; 5] = [1, 2, 3, 4, 5];
    println!("arrys {:?} ", numbers);
       
    //let mix = [1, 2, "text", 4];
    //println!("mix {:?}", mix)

    let string_array: [&str; 3] = ["aa", "bb", "cc"];
    println!("string array {:?}", string_array);

    // tuples
    let human = ("Rukmal", 30, true);
    println!("human {:?} ", human);

    let string: String = String::from("0123456 World");
    println!("string {}", string);

    let slice: &str = &string[0..5];
    println!("slice {} ", slice);

    //let x = Box
}
