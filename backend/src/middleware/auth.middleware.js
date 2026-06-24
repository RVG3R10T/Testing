const admin = require('firebase-admin');

/**
 * Middleware to verify Firebase ID token
 */
const verifyToken = async (req, res, next) => {
  try {
    const token = req.headers.authorization?.split('Bearer ')[1];

    if (!token) {
      return res.status(401).json({ error: 'No token provided' });
    }

    const decodedToken = await admin.auth().verifyIdToken(token);
    req.uid = decodedToken.uid;
    req.email = decodedToken.email;
    req.customClaims = decodedToken;

    next();
  } catch (error) {
    res.status(401).json({ error: 'Unauthorized', message: error.message });
  }
};

/**
 * Middleware to check if user has specific role
 */
const checkRole = (requiredRoles) => {
  return (req, res, next) => {
    const userRole = req.customClaims?.role;

    if (!userRole || !requiredRoles.includes(userRole)) {
      return res.status(403).json({ error: 'Insufficient permissions' });
    }

    next();
  };
};

module.exports = {
  verifyToken,
  checkRole,
};
