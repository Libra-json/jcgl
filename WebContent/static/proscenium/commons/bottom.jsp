<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	String	path = request.getContextPath(); %>
<div style="background-color: #2e6da4;">
	<div class="container">
		<div class="row" style="margin-top: 20px;text-align: center">
			<div class="col-xs-6 column">
				<p>
					<img alt="140x140" src="<%=path %>/static/proscenium/images/homepicture/${homeContent.qrcodeOne }" style="width: 90%;margin-bottom: 10px;" />
				</p>
				<h4><img src="<%=path %>/static/proscenium/images/phone5.png" style="width: 30%"><span>${homeContent.hcPhone }</span></h4>
				<h4>地址：<span>${homeContent.hcAddress }</span></h4>
			</div>
			<div class="col-xs-6 column">
				<p>
					<img alt="140x140" src="<%=path %>/static/proscenium/images/homepicture/${homeContent.qrcodeTwo }" style="width: 90%;margin-bottom: 20px;" />
				</p>
		    	<h4>友情链接</h4>
		    	<h4>
		    		<a class="bottom_link"  href="${homeContent.interlinkageOne }">学信网</a> | 
		    		<a class="bottom_link"  href="${homeContent.interlinkageTwo }">会计网</a>
	    		</h4>
		    	<h4>
		    		<a class="bottom_link"  href="${homeContent.interlinkageThree }">艺考网</a> | 
		    		<a class="bottom_link"  href="${homeContent.interlinkageFour }">成考网</a>
	    		</h4>
			</div>
    	</div>
	</div>
</div>