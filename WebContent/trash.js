function convert_to_tag(text) {
    let str = text.toLowerCase().split(' ').join('');
    return `<tr><td><label for="${str}">${text}: </label></td><td><input type="text" name="${str}" /></td></tr>`;
}

function generate_txt_1(text) {
    text = text.toLowerCase().split(' ').join('');
    return `String ${text} = request.getParameter("${text}");`;
}

let list = ["Product Code", "Product Name", "Product Description", "Product Scale", "Product Vendor", "Product Line", "Quantity", "Buy Price", "MSRP"];

for(let i of list) console.log(generate_txt_1(i));

