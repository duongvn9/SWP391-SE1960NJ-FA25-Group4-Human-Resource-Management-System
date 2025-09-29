package group4.hrms.repository.auth;

import group4.hrms.entity.User;
import group4.hrms.exception.DatabaseException;
import group4.hrms.repository.BaseRepository;

import java.util.Optional;

/**
 * Repository interface cho User entity
 */
public interface UserRepository extends BaseRepository<User, Long> {

    /**
     * Tìm user theo email
     */
    Optional<User> findByEmail(String email) throws DatabaseException;

    /**
     * Tìm user theo email và status active
     */
    Optional<User> findByEmailAndActive(String email) throws DatabaseException;

    /**
     * Kiểm tra email đã tồn tại chưa
     */
    boolean existsByEmail(String email) throws DatabaseException;

    /**
     * Tìm user theo reset token
     */
    Optional<User> findByResetToken(String resetToken) throws DatabaseException;

    /**
     * Cập nhật last login time
     */
    void updateLastLoginTime(Long userId) throws DatabaseException;

    /**
     * Cập nhật password
     */
    void updatePassword(Long userId, String newPasswordHash) throws DatabaseException;

    /**
     * Cập nhật reset token
     */
    void updateResetToken(Long userId, String resetToken,
            java.time.LocalDateTime expiresAt) throws DatabaseException;

    /**
     * Clear reset token
     */
    void clearResetToken(Long userId) throws DatabaseException;
}