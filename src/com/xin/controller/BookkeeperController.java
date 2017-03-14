package com.xin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.xin.bean.Academy;
import com.xin.bean.Student;
import com.xin.bean.User;
import com.xin.commons.base.BaseController;
import com.xin.commons.utils.PageInfo;
import com.xin.commons.utils.StudentNo;
import com.xin.service.BookkeeperService;
import com.xin.service.IAcademyService;
import com.xin.service.IStudentService;

/**
 * <p>
 *  会计培训报名
 * </p>
 * @author com.xin
 * @since 2017-02-28
 */
@Controller
@RequestMapping("/Bookkeeper")
public class BookkeeperController extends BaseController{
    
    @Autowired private BookkeeperService bookkeeperService;
    
    @Autowired private IAcademyService academyService;
    
    @Autowired private IStudentService studentservice;
    
    @GetMapping("/studentpage")
    public String student(){
    	return "admin/student/bookkeeper";
    }
    
    /**
     * 分页查询
     * @param student
     * @param page
     * @param rows
     * @return
     */
    @RequestMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(Student student,Integer page, Integer rows){
    	PageInfo pageInfo = new PageInfo(page,rows);
    	Map<String,Object> map = new HashMap<String,Object>();
    	if(student.getSName()!= null){
    		//根据姓名查询
    		map.put("name",student.getSName());
    	}
    	if(student.getStudentNo() != null){
    		//根据学号查询
    		map.put("studentNo", student.getStudentNo());
    	}
    	pageInfo.setCondition(map);
    	bookkeeperService.selectDataGrid(pageInfo);
    	return pageInfo;
    }
    
    @GetMapping("/addpage")
    public String addpage(Model model){
    	List<Academy> list = academyService.selectAll();
    	model.addAttribute("academy", list);
    	return "admin/student/bookkeeperAdd";
    }
    
    /**
     * 添加
     * @param student
     * @return
     */
    @RequestMapping("/add")
    @ResponseBody
    public Object add(Student student){
    	Student stu = studentservice.selectByNo();
    	String No = StudentNo.getNo(stu);
    	student.setStudentNo(No);
    	student.setStype(3);
    	boolean result = bookkeeperService.insertByid(student);
    	if(result == true){
    		return renderSuccess("添加成功");
    	}
    	return renderError("添加失败");
    }
    
    /**
     * 删除
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public Object delete(int id){
    	boolean result = bookkeeperService.deleteById(id);
    	if(result == true){
    		return renderSuccess("删除成功");
    	}
    	return renderError("删除删除失败");
    }
    
    @GetMapping("/editpage")
    public String editpage(Model model,int id){
    	Student student = bookkeeperService.selectById(id);
    	List<User> studentlsit = student.getListUser();
    	User user = null;
    	for(int j=0;j<studentlsit.size();j++){
    		 user = studentlsit.get(j);
    	}
    	model.addAttribute("user", user);
    	model.addAttribute("student", student);
    	return "admin/student/bookkeeperEdit";
    }
    
    /**
     * 修改
     * @param student
     * @return
     */
    @RequestMapping("edit")
    @ResponseBody
    public Object edit(Student student){
    	boolean result = bookkeeperService.updateById(student);
    	if(result == true){
    		return renderSuccess("修改成功");
    	}
    	return renderError("修改失败");
    }
}