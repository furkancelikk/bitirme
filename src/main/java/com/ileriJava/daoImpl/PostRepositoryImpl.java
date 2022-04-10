package com.ileriJava.daoImpl;

import com.ileriJava.dao.PostRepository;
import com.ileriJava.model.FaultRecords;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.List;


@Repository
public class PostRepositoryImpl implements PostRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public List<FaultRecords> findByUserID(Long userID) {
        Session session = sessionFactory.getCurrentSession();
        CriteriaBuilder cb = session.getCriteriaBuilder();
        CriteriaQuery<FaultRecords> cq = cb.createQuery(FaultRecords.class);

        Root<FaultRecords> faultRecordsRoot = cq.from(FaultRecords.class);
        Predicate idPredicate = cb.equal(faultRecordsRoot.get("userid").get("userid"), userID);
        cq.where(idPredicate);

        Query query = session.createQuery(cq);
        return query.getResultList();
    }
}