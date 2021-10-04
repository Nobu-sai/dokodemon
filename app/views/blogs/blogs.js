
// console.log("logged")

// window.addEventListener("load", () => {
// 	console.log("logged")
// })
// // $(document).ready(function() {	
// $(function() {	
// 	console.log("logged")
// 	// メモ投稿(POSTメソッド)の処理
// 	$("#blog_form").on("submit", function(e) {
// 	  e.preventDefault();  
// 		// デフォルトのイベント(HTMLデータ送信など)を無効にする
// 	  let blogTitle = $("#blog_form_title").val();  
// 	  let blogText = $("#blog_form_text").val();  
// 	  let blogFile = $("#blog_form_file").val();  
// 		// textareaの入力値を取得
// 	  let url = $(this).attr("action");  
// 		// action属性のurlを抽出
// 	  $.ajax({
// 	    url: url,  
// 		// リクエストを送信するURLを指定
// 	    type: "POST",  
// 		// HTTPメソッドを指定（デフォルトはGET）
// 	    data: {  
// 		// 送信するデータをハッシュ形式で指定
// 	      	blog: {
// 			title: blogTitle,
// 			text: blogText,
// 			file: blogFile,
// 			}
// 	    },
// 	    dataType: "json"  
// 		// レスポンスデータをjson形式と指定する
// 	  })
// 	  .done(function(data) {	   
// 		alert("success!");  
// 	  })
// 	  .fail(function() {
// 	    alert("error!");  
// 		// 通信に失敗した場合はアラートを表示
// 	  })
// 	  .always(function() {
// 	    $("#blog_form_btn").prop("disabled", false);  // submitボタンのdisableを解除
// 	    $("#blog_form_btn").removeAttr("data-disable-with");  // submitボタンのdisableを解除(Rails5.0以降はこちらも必要)
// 	  });
// 	});
// });
      