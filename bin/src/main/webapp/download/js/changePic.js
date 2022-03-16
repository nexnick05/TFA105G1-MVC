/**
 * 
 */
var changePic_el = document.getElementById("changePic");
var p_file_el = document.getElementById("p_file");

var changePic_img = function(file) {
	var reader = new FileReader();
	reader.readAsDataURL(file);
	reader.addEventListener("load", function() {
		let img_str = '<label for="p_file" id="pic-file"><img src="' + reader.result + '"></label>';
		changePic_el.innerHTML = img_str;
	});
};
p_file_el.addEventListener("change", function(e) {
	if (this.files.length > 0) {
		changePic_img(this.files[0]);
	} else {
		changePic_el.innerHTML = '<label for="p_file" id="pic-file"><img src="<%=request.getContextPath()%>/member/member.pic?memberid=${memberVO.memberid}"></label>';
	}
});


