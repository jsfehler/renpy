cdef class Matrix:

    cdef public float xdx
    cdef public float ydx
    cdef public float zdx
    cdef public float wdx

    cdef public float xdy
    cdef public float ydy
    cdef public float zdy
    cdef public float wdy

    cdef public float xdz
    cdef public float ydz
    cdef public float zdz
    cdef public float wdz

    cdef public float xdw
    cdef public float ydw
    cdef public float zdw
    cdef public float wdw

    # This can be replaced with a cdef inline property when Cython 3 comes
    # out.
    cdef float *m

    # When this matrix is generated, where it was generated from.
    cdef public object origin

    # The inverse of this Matrix.
    cdef Matrix inverse_cache

    # The transpose of this Matrix.
    cdef Matrix transpose_cache

    cdef inline void transform4(Matrix self, float *ox, float *oy, float *oz, float *ow, float x, float y, float z, float w):
        ox[0] = x * self.xdx + y * self.xdy + z * self.xdz + w * self.xdw
        oy[0] = x * self.ydx + y * self.ydy + z * self.ydz + w * self.ydw
        oz[0] = x * self.zdx + y * self.zdy + z * self.zdz + w * self.zdw
        ow[0] = x * self.wdx + y * self.wdy + z * self.wdz + w * self.wdw

    cdef inline void transform3(Matrix self, float *ox, float *oy, float *oz, float x, float y, float z, float w):
        ox[0] = x * self.xdx + y * self.xdy + z * self.xdz + w * self.xdw
        oy[0] = x * self.ydx + y * self.ydy + z * self.ydz + w * self.ydw
        oz[0] = x * self.zdx + y * self.zdy + z * self.zdz + w * self.zdw

    cdef inline void transform2(Matrix self, float *ox, float *oy, float x, float y, float z, float w):
        ox[0] = x * self.xdx + y * self.xdy + z * self.xdz + w * self.xdw
        oy[0] = x * self.ydx + y * self.ydy + z * self.ydz + w * self.ydw

    cpdef bint is_unit_aligned(Matrix self)

    cpdef Matrix inverse(Matrix self)

    cpdef Matrix transpose(Matrix self)

    cdef inline void ctake(Matrix self, Matrix other):
        """
        Take the values from another matrix, and put them into this one.
        """

        self.xdx = other.xdx
        self.xdy = other.xdy
        self.xdz = other.xdz
        self.xdw = other.xdw

        self.ydx = other.ydx
        self.ydy = other.ydy
        self.ydz = other.ydz
        self.ydw = other.ydw

        self.zdx = other.zdx
        self.zdy = other.zdy
        self.zdz = other.zdz
        self.zdw = other.zdw

        self.wdx = other.wdx
        self.wdy = other.wdy
        self.wdz = other.wdz
        self.wdw = other.wdw

    cdef Matrix inplace_multiply(Matrix self, Matrix other)
    cdef Matrix inplace_offset(Matrix self, float xo, float yo)
    cdef Matrix inplace_reverse_offset(Matrix self, float xo, float yo)
    cdef Matrix inplace_inverse(Matrix self)
    cdef Matrix inplace_transpose(Matrix self)

    @staticmethod
    cdef bint is_drawable_aligned(Matrix a, Matrix b)

    @staticmethod
    cdef Matrix cidentity()

    @staticmethod
    cdef Matrix coffset(float x, float y, float z)

    @staticmethod
    cdef Matrix crotate(float x, float y, float z)

    @staticmethod
    cdef Matrix cscale(float x, float y, float z)

    @staticmethod
    cdef Matrix cperspective(float w, float h, float n, float p, float f)

    @staticmethod
    cdef Matrix cscreen_projection(float w, float h)

    @staticmethod
    cdef Matrix ctexture_projection(float w, float h)


cdef class Matrix2D(Matrix):
    pass
