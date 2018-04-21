/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.DAO;

import com.beans.Compte;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Stateless
public class CompteDAO extends AbstractDAO<Compte> {

    @PersistenceContext(unitName = "PCDPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CompteDAO() {
        super(Compte.class);
    }

    public List<Compte> findAll() {
        return getEntityManager().createNamedQuery("Compte.findAll").getResultList();
    }
    
     
}
