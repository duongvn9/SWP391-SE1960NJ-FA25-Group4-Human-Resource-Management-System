package group4.hrms.repository;

import group4.hrms.exception.DatabaseException;

import java.util.List;
import java.util.Optional;

/**
 * Base repository interface chứa các CRUD operations cơ bản
 */
public interface BaseRepository<T, ID> {

    /**
     * Tìm entity theo ID
     */
    Optional<T> findById(ID id) throws DatabaseException;

    /**
     * Tìm tất cả entities
     */
    List<T> findAll() throws DatabaseException;

    /**
     * Tìm entities với phân trang
     */
    List<T> findAll(int offset, int limit) throws DatabaseException;

    /**
     * Đếm tổng số records
     */
    long count() throws DatabaseException;

    /**
     * Lưu entity (insert hoặc update)
     */
    T save(T entity) throws DatabaseException;

    /**
     * Lưu nhiều entities
     */
    List<T> saveAll(List<T> entities) throws DatabaseException;

    /**
     * Xóa entity theo ID
     */
    void deleteById(ID id) throws DatabaseException;

    /**
     * Xóa entity
     */
    void delete(T entity) throws DatabaseException;

    /**
     * Soft delete entity theo ID
     */
    void softDeleteById(ID id) throws DatabaseException;

    /**
     * Kiểm tra entity có tồn tại không
     */
    boolean existsById(ID id) throws DatabaseException;
}