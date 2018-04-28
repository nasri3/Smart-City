/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.DAO;

import com.beans.Evenement;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Wissem
 */
@Stateless
public class EvenementDAO extends AbstractDAO<Evenement> {

    @PersistenceContext(unitName = "PCDPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public EvenementDAO() {
        super(Evenement.class);
    }

    public List<Evenement> findAll() {
        return getEntityManager().createNamedQuery("Evenement.findAll").getResultList();
    }
    
}
