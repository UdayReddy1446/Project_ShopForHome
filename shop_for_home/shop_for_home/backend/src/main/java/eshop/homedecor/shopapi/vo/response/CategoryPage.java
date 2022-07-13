package eshop.homedecor.shopapi.vo.response;

import org.springframework.data.domain.Page;

import eshop.homedecor.shopapi.entity.ProductInfo;

/**
 * Created By Zhu Lin on 12/28/2018.
 */
public class CategoryPage {
    private String category;
    private Page<ProductInfo> page;

    public CategoryPage(String category, Page<ProductInfo> page) {
        this.category = category;
        this.page = page;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Page<ProductInfo> getPage() {
        return page;
    }

    public void setPage(Page<ProductInfo> page) {
        this.page = page;
    }
}
