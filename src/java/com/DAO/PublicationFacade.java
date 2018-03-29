/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.DAO;

import com.beans.Compte;
import com.beans.Publication;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Stateless
public class PublicationFacade extends AbstractFacade<Publication> {

    @PersistenceContext(unitName = "PCDPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PublicationFacade() {
        super(Publication.class);
    }

    public List<Publication> findAll() {
        return getEntityManager().createNamedQuery("Publication.findAll").getResultList();
    }

    public List<Publication> getFirst5() {
        return getEntityManager().createNamedQuery("Publication.findAll").setMaxResults(5).getResultList();
    }
    
    public List<Publication> getFirst5(Compte compte) {
        return getEntityManager().createNamedQuery("Publication.findbyCompte").setParameter("compte", compte).setMaxResults(5).getResultList();
    }

    public List<Publication> get3After(int idDerniere) {
        return getEntityManager().createNamedQuery("Publication.findAllAfterId").setParameter("idDerniere", idDerniere).setMaxResults(3).getResultList();
    }

    public List<Publication> get3After(int idDerniere, Compte compte) {
        return getEntityManager().createNamedQuery("Publication.findbyCompteAfterId").setParameter("compte", compte).setParameter("idDerniere", idDerniere).setMaxResults(3).getResultList();
    }

}
