package eshop.homedecor.shopapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import eshop.homedecor.shopapi.entity.Cart;

/**
 * Created By Zhu Lin on 1/2/2019.
 */

public interface CartRepository extends JpaRepository<Cart, Integer> {
}
