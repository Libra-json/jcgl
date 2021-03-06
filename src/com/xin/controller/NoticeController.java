package com.xin.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.Model;
import com.xin.bean.Notice;
import com.xin.commons.base.BaseController;
import com.xin.commons.utils.PageInfo;
import com.xin.commons.utils.PageJson;
import com.xin.commons.utils.StringUtils;
import com.xin.service.INoticeService;

/**
 * 
 * @author Mr.Lin
 * @date 2017-3-03
 */
@Controller
@RequestMapping("/notice")
public class NoticeController extends BaseController{
    
    @Autowired private INoticeService noticeService;
    
    /**
     * 公告管理页
     * @return
     * */
    @GetMapping("/manager")
    public String manager() {
    	return "admin/notice/noticeManager";
    }
    
    /**
     * 公告管理列表
     *
     * @param notice
     * @param page
     * @param rows
     * @param sort
     * @param order
     * @return
     */
    @PostMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(Notice notice, Integer page, Integer rows, String sort, String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        if (StringUtils.isNotBlank(notice.getNTitle())) {
            condition.put("nTitle", StringUtils.formatLike(notice.getNTitle()));
        }
        if (notice.getNFlag() != null && notice.getNFlag()!=0) {
            condition.put("nFlag", notice.getNFlag());
        }
        if (notice.getNDate() != null) {
            condition.put("startTime", notice.getNDate());
        }
        if (notice.getEndDate() != null) {
            condition.put("endTime", notice.getEndDate());
        }
        pageInfo.setCondition(condition);
        noticeService.selectDataGrid(pageInfo);
        return pageInfo;
    }
    
    @RequestMapping("/queryBypages")
    @ResponseBody
    public PageJson<Notice> queryByPages(PageJson<Notice> pages,@RequestParam int offset,@RequestParam int limit,HttpServletRequest request){
    	String search = request.getParameter("search");
		if(search==null||("").equals(search.trim())||("null").equals(search)){
			search="";		
		}
		search="%"+search+"%";
		System.out.println(search);
		pages.setRows(noticeService.queryByPages(search, offset, limit));
		pages.setTotal(noticeService.queryTotal(search));
		return pages;
    }
    /**
     * 公告添加页
     *
     * @return
     */
    @GetMapping("/addPage")
    public String addPage() {
        return "admin/notice/noticeAdd";
    }
    
    /**
     * 添加公告
     *
     * @param notice
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(Notice notice) {
    	int result = noticeService.noticeInsert(notice);
    	if(result>0) {
    		return renderSuccess("添加成功");
    	}else {
    		return renderError("添加失败");
    	}
    }
    
    /**
     * 编辑公告页
     * @param model
     * @param id
     * @return
     * */
    @GetMapping("/editPage")
    public String editPage(Model model, int id) {
    	Notice n = noticeService.selectNoticeById(id);
    	model.addAttribute("notice", n);
    	return "admin/notice/noticeEdit";
    }
    
    /**
     * 编辑公告
     * @param notice
     * @return
     * */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(Notice notice) {
    	int result = noticeService.updateNotice(notice);
    	if(result>0) {
    		return renderSuccess("添加成功");
    	}else {
    		return renderError("添加失败");
    	}
    }
    
    /**
     * 删除公告
     * @param id
     * */
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(int id) {
    	noticeService.deleteNotice(id);
    	return renderSuccess("删除成功");
    }
    
    /**
     * 根据id查询公告
     * @param model
     * @param id
     * @return
     * */
    @GetMapping("/selectById")
    public String selectById(Model model, int id) {
    	model.addAttribute("homeContent", homeContent());
    	Notice n = noticeService.selectNoticeById(id);
    	
    	model.addAttribute("notice", n);
    	return "proscenium/notice_particular";
    }
    
    /**
     * 更多页面
     * */
    @GetMapping("/selectMore")
    public String selectMore(Model model) {
    	model.addAttribute("homeContent", homeContent());
    	return "proscenium/notice";
    }
}
